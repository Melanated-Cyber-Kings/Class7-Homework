#!/bin/bash
set -xe

# Base system
dnf update -y
dnf install -y dnf-plugins-core fontconfig java-21-amazon-corretto-devel jq wget

# Terraform repo
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
dnf install -y terraform

# --- RELIABLE JENKINS REPO SETUP (fixes your repolist issue) ---
# Retry until networking is ready and repo downloads successfully
until wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo; do
  echo "Retrying Jenkins repo download..."
  sleep 3
done

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
dnf install -y jenkins
# ---------------------------------------------------------------

# Jenkins temp directory
mkdir -p /var/lib/jenkins/tmp
chown jenkins:jenkins /var/lib/jenkins/tmp
chmod 700 /var/lib/jenkins/tmp

mkdir -p /etc/systemd/system/jenkins.service.d
cat <<EOF > /etc/systemd/system/jenkins.service.d/override.conf
[Service]
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.io.tmpdir=/var/lib/jenkins/tmp"
Environment="JENKINS_JAVA_CMD=/usr/bin/java"
EOF

systemctl daemon-reload

# Generate admin password
RANDOM_PWD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 24)
echo "JENKINS INITIAL ADMIN PASSWORD: $RANDOM_PWD" | tee -a /var/log/cloud-init-output.log

# Bypass setup wizard
mkdir -p /var/lib/jenkins/init.groovy.d/
echo "2.462" > /var/lib/jenkins/jenkins.install.UpgradeWizard.state
echo "2.462" > /var/lib/jenkins/jenkins.install.InstallUtil.lastExecVersion

# Create admin user
cat <<EOF > /var/lib/jenkins/init.groovy.d/basic-security.groovy
#!groovy
import jenkins.model.*
import hudson.security.*

def instance = Jenkins.get()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount('admin', '$RANDOM_PWD')
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)
instance.save()
EOF

chown -R jenkins:jenkins /var/lib/jenkins

# Plugin bootstrap
cat <<EOF > /tmp/plugins.yaml
plugins:
  - git:latest
  - workflow-aggregator:latest
  - aws-credentials:latest
  - pipeline-aws:latest
  - ec2:latest
  - amazon-ecs:latest
  - codedeploy:latest
  - aws-lambda:latest
  - aws-codebuild:latest
  - aws-bucket-credentials:latest
  - aws-secrets-manager-secret-source:latest
  - aws-codepipeline:latest
  - configuration-as-code-secret-ssm:latest
  - cloudformation:latest
  - aws-sam:latest
  - terraform:latest
  - kubernetes:latest
  - google-storage-plugin:latest
  - google-kubernetes-engine:latest
  - google-oauth-plugin:latest
  - pipeline-gcp:latest
  - snyk-security-scanner:latest
  - sonar:latest
  - aqua-security-scanner:latest
  - aqua-microscanner:latest
  - github:latest
  - github-oauth:latest
  - pipeline-github:latest
  - pipeline-githubnotify-step:latest
  - maven-plugin:latest
  - pipeline-maven:latest
  - publish-over-ssh:latest
EOF

curl -fLs -o /tmp/jenkins-plugin-manager.jar \
  https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.14.0/jenkins-plugin-manager-2.14.0.jar

sudo -u jenkins java -jar /tmp/jenkins-plugin-manager.jar \
  --war /usr/share/java/jenkins.war \
  --plugin-download-directory /var/lib/jenkins/plugins \
  --plugin-file /tmp/plugins.yaml

systemctl enable --now jenkins
