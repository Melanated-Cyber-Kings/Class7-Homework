# VPC resource
# This creates the virtual private cloud
resource "aws_vpc" "app1" {
  
  # region = ""
  
  cidr_block           = "10.25.0.0/16"
  
  #enable public DNS for ec2
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "demo-vpc"
  }

}
