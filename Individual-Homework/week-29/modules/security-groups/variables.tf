variable "project_name" {
  type        = string
  description = "Project name prefix for security groups"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where security groups will be created"
}

variable "jenkins_port" {
  type        = number
  description = "Port Jenkins listens on"
}
