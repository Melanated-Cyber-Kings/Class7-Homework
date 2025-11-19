variable "vpc_cidr_block" { description = "CIDR block." }
variable "env_prefix" { description = "Prefixes all resource names." }
variable "aws_region" { description = "The AWS region." }
variable "profile" { description = "The AWS CLI profile to use." }

variable "my_ip" {
  description = "My IP address for SSH access to the bastion (e.g., '1.2.3.4/32')."
  type        = string
}

variable "key_name" {
  description = "The name for the EC2 Key Pair for bastion access."
  type        = string
}

variable "bastion_public_key_path" {
  description = "The file path to the public SSH key for the bastion (e.g., 'bastion-key.pub')."
  type        = string
}

variable "web_server_instance_type" {
  description = "Instance type for the web servers managed by the ASG."
  type        = string
  default     = "t3.micro"
}

variable "web_server_ami_id" {
  description = "AMI ID for the web server instances (Amazon Linux 2)."
  type        = string
  default     = "ami-09968b16214ef62ce" 
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group."
  type        = number
  default     = 3
}

variable "bastion_instance_type" {
  description = "Instance type for the Linux bastion host."
  type        = string
  default     = "t3.micro" 
}

variable "bastion_ami_id" {
  description = "AMI ID for the Amazon Linux 2 bastion host."
  type        = string
  default     = "ami-09968b16214ef62ce" 
}