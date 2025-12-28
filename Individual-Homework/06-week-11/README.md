# AWS High Availability Website (Terraform)

## 📌 Project Overview

This repository contains a proof-of-concept infrastructure deployment of a **high-availability website** on **Amazon Web Services (AWS)** using **Terraform**.

The solution demonstrates how to design and provision:
- A highly available architecture across multiple Availability Zones
- Public and private subnets
- Auto Scaling Group for application servers
- An Application Load Balancer (ALB)
- Reusable and parameterized infrastructure via Terraform variables

## 🏗 Architecture

The deployed infrastructure includes:
- 3 Public Subnets
- 3 Private Subnets
- Auto Scaling Group for scalable web servers
- Application Load Balancer for high availability and fault tolerance
- All resources deployed within a single AWS region across 3 AZs


## 🧰 Tools & Technologies

| Technology | Version / Notes |
|------------|----------------|
| AWS        | Latest supported |
| Terraform  | ≥ 1.0.0 |
| Linux / Bash | For local Terraform execution |

## 🚀 Getting Started

### 1. Clone Repository
```
git clone https://github.com/Melanated-Cyber-Kings/Class7-Homework.git
cd Class7-Homework/Individual-Homework/06-week-11
```

### 2. Initialize Terraform
```
cd terraform_code
terraform init
```

### 3. Review & Set Variables
Update terraform.tfvars or use environment variables for credentials and region.

```
aws_region = "us-east-1"
```

### 4. Deploy Infrastructure

```
terraform plan
terraform apply
```

### 5. Destroy Infrastructure (if needed)

```
terraform destroy
```


📁 Folder Structure

06-week-11/
├── README.md
└── terraform_code/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf

    
[NOTES] 

Ensure AWS credentials are configured via AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY or a credentials file. Do not put your AWS credentials in any file where they could possibly get uploaded to a public or private repository.
