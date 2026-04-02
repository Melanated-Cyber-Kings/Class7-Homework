variable "project_name" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "jenkins_sg_id" {
  type = string
}

variable "instance_type" {
  type = string
}



variable "user_data" {
  type = string
}

variable "root_volume_size" {
  type        = number
  description = "Size of the root EBS volume in GiB"
}

variable "root_volume_type" {
  type        = string
  description = "Type of the root EBS volume (e.g., gp3, gp2)"
}

variable "instance_profile" {
  type = string
}
