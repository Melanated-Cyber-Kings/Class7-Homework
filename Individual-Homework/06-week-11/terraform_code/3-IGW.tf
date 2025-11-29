resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name    = "IGW"
    Service = var.service
    Owner   = var.owner
    Planet  = var.planet
  }
}
