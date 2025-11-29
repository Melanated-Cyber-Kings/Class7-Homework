# this  makes  vpc.id which is aws_vpc.demo.id
resource "aws_vpc" "demo" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name    = "${var.vpc_name}"
    Service = var.service
    Owner   = var.owner
    Planet  = var.planet
  }
}