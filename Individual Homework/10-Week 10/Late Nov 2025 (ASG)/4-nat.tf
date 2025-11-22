resource "aws_eip" "SofiaS-nat" {

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "SofiaS-nat" {
  allocation_id = aws_eip.SofiaS-nat.id
  subnet_id     = aws_subnet.public-eu-west-1a.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}