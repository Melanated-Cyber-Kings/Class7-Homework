############################################
# Required Inputs
############################################

variable "project_name" {
  description = "Project name used for IAM resource naming"
  type        = string
}

variable "region" {
  description = "AWS region (passed from root module)"
  type        = string
}

############################################
# Secret ARNs (from secrets module)
############################################

variable "jenkins_admin_secret_arn" {
  description = "ARN of the Jenkins admin password secret (SSM or Secrets Manager)"
  type        = string
}

variable "github_pat_secret_arn" {
  description = "ARN of the GitHub PAT secret (SSM or Secrets Manager)"
  type        = string
}
