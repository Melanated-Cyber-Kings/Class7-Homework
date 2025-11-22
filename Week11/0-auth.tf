# Terraform configuration block
# This defines the minimum Terraform version and required providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# AWS Provider configuration
# This tells Terraform how to connect to AWS
provider "aws" {
  region = "us-east-1"
  
  # Default tags are applied to all resources created by this provider
  default_tags {
    tags = {
      Project     = "class7"
      Day         = "Tuesday"
      Date        = "2025-11-01"
      ManagedBy   = "Rob O"
      Theme       = "Make Up Week Terraform"
    }
  }
}