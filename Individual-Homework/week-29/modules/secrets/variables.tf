variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "secret_backend" {
  type        = string
  description = "Choose 'ssm', 'secretsmanager', or 'both'."
  default     = "ssm"
}

variable "destroy_secrets" {
  type        = bool
  description = "If true, use destroyable Secrets Manager secrets."
  default     = false
}

variable "jenkins_admin_password" {
  type = string
}

variable "github_pat" {
  type = string
}

