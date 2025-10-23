resource "aws_route_table" "public" {
  vpc_id   = aws_vpc.hw4-bastion-bam.id

  route {
    cidr_block                = "0.0.0.0/0"
    gateway_id                = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "HW4 BAM Public Route Table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.hw4-bastion-bam.id

  route {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.nat.id

    }

  tags = {
    Name = "Hw4 Bam Private Route Table"
  }
}

#private
resource "aws_route_table_association" "private-us-east-1a" {
  subnet_id      = aws_subnet.us-east-1a-private-subnet.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-us-east-1b" {
  subnet_id      = aws_subnet.us-east-1b-private-subnet.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private-us-east-1c" {
  subnet_id      = aws_subnet.us-east-1c-private-subnet.id
  route_table_id = aws_route_table.private.id
}


#public

resource "aws_route_table_association" "public-us-east-1a" {
  subnet_id      = aws_subnet.us-east-1a-public-subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-east-1b" {
  subnet_id      = aws_subnet.us-east-1b-public-subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-east-1c" {
  subnet_id      = aws_subnet.us-east-1c-public-subnet.id
  route_table_id = aws_route_table.public.id
}









































