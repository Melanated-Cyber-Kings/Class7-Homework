resource "aws_vpc" "hw4-bastion-bam" {
  # The CIDR block for the VPC chosen at random by me
  cidr_block       = "10.55.0.0/16"
  enable_dns_hostnames = true           # Enable DNS hostnames in the VPC
  region = "us-east-1"                     # Specify the AWS region for the VPC

  
  
  # Tags for the VPC
  tags = {
    Name = "hw4-bastion-be-a-man"
  }
}














