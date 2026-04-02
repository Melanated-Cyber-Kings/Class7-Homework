variable "project_name" {
  type        = string
  description = "Project name prefix for ALB resources"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs for ALB"
}

variable "alb_sg_id" {
  type        = string
  description = "Security group ID for ALB"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where ALB will be created"
}

variable "jenkins_port" {
  type        = number
  description = "Port Jenkins listens on"
}

variable "acm_certificate_arn" {
  type        = string
  description = "ACM certificate ARN for HTTPS listener"
}
