####################################################################
# VPC settings
####################################################################

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}


variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.22.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "demo"
  nullable    = false
}

variable "service" {
  description = "Identify type of service."
  type        = string
  default     = "Application"
}

variable "owner" {
  description = "Identify owner of project."
  type        = string
  default     = "Mr. Majestikk"
}

variable "planet" {
  description = "Identify location of service."
  type        = string
  default     = "Saturn"
}

locals {
  zone1 = "${var.aws_region}a"
  zone2 = "${var.aws_region}b"
  zone3 = "${var.aws_region}c"
}

####################################################################
# Public Subnet
####################################################################

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for all subnets by name"
  type = object({
    public_zone1 = string
    public_zone2 = string
    public_zone3 = string
  })

  default = {
    public_zone1 = "10.22.1.0/24"
    public_zone2 = "10.22.2.0/24"
    public_zone3 = "10.22.3.0/24"
  }
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is `false`"
  type        = bool
  default     = false
}



####################################################################
# Private Subnet
####################################################################

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for all subnets by name"
  type = object({
    private_zone1 = string
    private_zone2 = string
    private_zone3 = string

  })

  default = {
    private_zone1 = "10.22.11.0/24"
    private_zone2 = "10.22.12.0/24"
    private_zone3 = "10.22.13.0/24"
  }
}



####################################################################
# Tags
####################################################################

variable "resource_tags" {
  description = "Tags for all resources"
  type        = map(string)
  default = {
    Service     = "Training-Sandbox",
    environment = "dev"
  }
}

variable "sg_tags" {
  description = "Tags for security groups"
  type        = string
  default     = ""

}

####################################################################
# EC2 Settings
####################################################################


variable "ec2_instance_type" {
  description = "AWS EC2 instance type."
  type        = string
  default     = ""
}

variable "key_name" {
  description = "EC2 SSH key name."
  type        = string
  default     = ""

}

####################################################################
# Secure Shell Key for Auto Scaling Group Template
####################################################################

variable "template_ssh_key" {
  description = "SSH keyname for EC2 template"
  type        = string
  default     = ""

}