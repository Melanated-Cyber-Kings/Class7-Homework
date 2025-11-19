resource "aws_eip" "nat" {

  tags = {
    Name = "nat"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-eu-west-3a.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}