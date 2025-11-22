# this  makes  vpc.id which is aws_vpc.app1.id
resource "aws_vpc" "SofiaS" {
  cidr_block           = "10.105.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "SofiaS"
    Service = "application1"
    Owner   = "Chewbacca"
    Planet  = "Mustafar"
  }
}