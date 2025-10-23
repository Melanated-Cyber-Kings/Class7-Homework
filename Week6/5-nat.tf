resource "aws_eip" "nat" {

  tags = {
    Name = "Bastion-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.us-east-1a-public-subnet.id
  
  
  tags = {
    Name = "Bastion-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}