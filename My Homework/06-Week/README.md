# 🌍 Week 6: Terraform Class Prep

## ✅ Recommendations for Terraform Class Preparation

### 🧠 1. Git & GitHub Skills
- Make sure you can easily use **Git/GitHub**, including the `git clone` command.
- Be able to effectively use **Git Bash** or your **terminal** for basic file management (e.g., navigating directories, creating/deleting files).

---

### 🌐 2. Networking / VPC Knowledge
- Complete **Maarek’s course sections** on **Networking/VPC** (this was previous homework).
- Be able to **explain what the following are**, **why we use them**, and **how to create them** in the AWS console:
  - **VPC**
  - **Subnet**
  - **Route Table**
  - **Elastic IP (EIP)**
  - **Internet Gateway (IGW)**
  - **NAT Gateway (NAT GW)**
- Review **AWS CLI commands** for creating and managing these resources.
  - Pay special attention to:  

    ```bash
    aws ec2 associate-route-table
    ```

  - Understand **why and when** you would need to use this command.

---

### 📚 3. Networking Fundamentals Review
- Make sure you’re **comfortable with networking terminology** — this will **not** be re-taught in class.
- Be able to:
  - **Design a network** using **CIDR ranges**.
  - Explain how **Availability Zones (AZs)** relate to **Subnets**.
  - Describe **public vs private traffic**.
  - Explain **why NAT Gateways** or **Route Tables** are needed.

> ⚠️ If you can’t architect a network or explain these terms clearly, this class will be very challenging.

---

### ⚙️ 4. Terraform Familiarity
- Watch a **YouTube tutorial on Terraform** (1 hour is plenty).
  - Even if you skip the labs, understand the following concepts:
    - **Providers**
    - **Variables**
    - **Resources**
    - **Data Sources**
    - **Arguments vs Attributes**
    - **State Files**
    - **Basic HCL Syntax**
- A short video overview is fine — the goal is to **grasp Terraform’s structure and workflow**.

---

### 🧰 5. AWS CLI Access
- Ensure this command works correctly:

  ```bash
  aws sts get-caller-identity
  ```

> This verifies that your AWS credentials and CLI configuration are working properly.