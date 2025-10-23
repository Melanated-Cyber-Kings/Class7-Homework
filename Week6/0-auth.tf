provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      hmwk = "BAM"
      week = "4"
      teamLead = "Charles Manning"
      teamName = "IT Ultimate Study Group"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.17.0"
    }
  }
}
