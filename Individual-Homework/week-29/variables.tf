############################################
# Global Settings
############################################

variable "region" {
  type        = string
  description = "AWS region for all resources"
  default     = "eu-central-1"
}

variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
  default     = "cloudforge-jenkins"
}

############################################
# Networking (Multi-AZ)
############################################

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_a" {
  type        = string
  description = "CIDR block for public subnet A"
}

variable "public_subnet_cidr_b" {
  type        = string
  description = "CIDR block for public subnet B"
}

variable "private_subnet_cidr_a" {
  type        = string
  description = "CIDR block for private subnet A"
}

variable "private_subnet_cidr_b" {
  type        = string
  description = "CIDR block for private subnet B"
}

variable "az_a" {
  type        = string
  description = "Availability Zone A"
}

variable "az_b" {
  type        = string
  description = "Availability Zone B"
}

############################################
# DNS / ACM
############################################

variable "domain_name" {
  type        = string
  description = "Domain name for Route 53 and ACM"
}

variable "acm_certificate_arn" {
  type        = string
  description = "ACM certificate ARN for HTTPS via ALB"
  default     = null
}

############################################
# EC2 / Jenkins
############################################

variable "instance_type" {
  type        = string
  description = "EC2 instance type for Jenkins"
}

variable "root_volume_size" {
  type        = number
  description = "Root EBS volume size (GB)"
}

variable "root_volume_type" {
  type        = string
  description = "Root EBS volume type"
}

variable "jenkins_port" {
  type        = number
  description = "Port Jenkins listens on"
  default     = 8080
}

############################################
# Secrets (Credentials)
############################################

variable "jenkins_admin_password" {
  description = "Jenkins admin password"
  type        = string
  sensitive   = true
}

variable "github_pat" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

############################################
# Secrets Backend Configuration
############################################

variable "secret_backend" {
  description = "Where to store secrets: ssm, secretsmanager, or both"
  type        = string
  default     = "ssm"
}

variable "destroy_secrets" {
  description = "Whether Secrets Manager secrets can be destroyed"
  type        = bool
  default     = false
}

############################################
# Optional S3 Bucket
############################################

variable "enable_bucket" {
  type        = bool
  description = "Enable optional S3 bucket creation"
  default     = false
}

variable "app_subdomain" {
  type        = string
  description = "Subdomain for the Jenkins ALB (e.g., app)"
}
