# 🎡 Automated Jenkins CI/CD Environment (Java 21 Upgrade)

## 🎯 Objective
The goal of this lab was to automate the deployment of a **Jenkins CI/CD server**, moving beyond manual installation to a scripted, repeatable process. A key focus was upgrading the environment from Java 17 to **Java 21** and automating the plugin installation phase to reach a "ready-to-work" state immediately after boot.

---

## 🛠️ Infrastructure & Automation
I rebuilt the Jenkins server on an **Amazon EC2 (Amazon Linux 2023)** instance. Unlike traditional manual setups, this deployment utilized an automated bash script to handle the repository configuration, security key imports, and dependency management.

### Key Upgrade: Java 17 ➡️ Java 21
To align with the latest industry standards, I replaced the default OpenJDK 17 with **Amazon Corretto 21**. This ensures compatibility with the newest Jenkins features and provides a more robust execution environment for modern build pipelines.

---

## 📜 Automation Script Logic
The deployment was driven by a user-data script that performed the following operations:
1. **System Updates:** Fully patched the OS prior to installation.
2. **Repository Configuration:** Added the official Jenkins Red Hat repository.
3. **Environment Setup:** Installed `java-21-amazon-corretto-devel`.
4. **Service Management:** Enabled and started the Jenkins daemon automatically.
5. **Plugin Automation:** Utilized a plugin installation script to pre-load required tools, bypassing the manual "Suggested Plugins" wizard.

---

## 📸 Execution Evidence
The following screenshots confirm the successful automation of the Jenkins environment and the plugin ecosystem:

### Automated Plugin Installation
These images show the terminal output and Jenkins UI confirming that the plugin installation script executed successfully without manual intervention.

* **Script Success Log:** ![Plugin Script Success](screenshots/jenkins-plugin-install-script-success.png)
* **Plugin Verification 1:** ![Plugin Success 1](screenshots/jenkins-plugin-install-script-success1.png)
* **Plugin Verification 2:** ![Plugin Success 2](screenshots/jenkins-plugin-install-script-success2.png)

---

## 🧠 Key Takeaways
* **Configuration as Code (CaC):** By scripting the installation of both the service and its plugins, the "Time to First Build" is significantly reduced.
* **Dependency Management:** Transitioning to Java 21 required adjusting the repository imports to ensure the correct Corretto package was pulled during the yum install phase.
* **Scalability:** This process can now be easily ported into a Dockerfile or an AWS Launch Template for auto-scaling Jenkins agents or controllers.

---

### 🏁 Final Cleanup
To maintain cost-effective cloud hygiene:
1. Stopped the EC2 instance.
2. Terminated the instance and associated EBS volumes once the automation logs were verified.