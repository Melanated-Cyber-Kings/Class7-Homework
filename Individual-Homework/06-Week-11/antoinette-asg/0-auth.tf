terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.0"
      
    }
  }
}

provider "aws" {

    #Config options

    # default region
    region = var.aws_region
    # auth profile
    profile = var.profile

    # default_tags {
    #   tags = {
    #     Environment = "Lab"
    #     ManagedBy = "Terraform"
    #   }
    # }
}