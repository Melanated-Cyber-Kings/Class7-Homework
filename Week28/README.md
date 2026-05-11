# 🏗️ Jenkins CI/CD Pipeline: Terraform Lifecycle Automation

## 🎯 Objective
The goal of this lab was to integrate **Jenkins** with **GitHub** and **Terraform** to create a fully automated CI/CD pipeline. The pipeline was designed to pull code from a repository and execute a standard Terraform workflow, ensuring code quality and infrastructure cleanup through automated stages.

---

## 🛠️ Pipeline Architecture
The pipeline is defined via a `Jenkinsfile` (Pipeline as Code) and executes the following stages:

1.  **Checkout:** Automatically pulls the latest code from the GitHub repository.
2.  **Terraform Operations:**
    * **Init:** Initializes the backend and provider plugins.
    * **Fmt:** Checks for proper canonical formatting and style.
    * **Validate:** Programmatically verifies the configuration files for internal consistency.
    * **Destroy:** Executes an automated teardown of the resources using the `--auto-approve` flag to ensure the environment is ephemeral and cost-effective.

---

## 📄 Jenkinsfile Configuration
To maintain security, the pipeline uses the `withAWS` wrapper to inject sensitive credentials (`jenkins-creds`) only during the execution phase, preventing hardcoded secrets in the repository.

```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps { checkout scm }
        }
        stage('Terraform Operations') {
            steps {
                withAWS(credentials: 'jenkins-creds', region: 'us-east-1') {
                    dir('Week28') {
                        sh 'terraform init'
                        sh 'terraform fmt'
                        sh 'terraform validate'
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
    }
}