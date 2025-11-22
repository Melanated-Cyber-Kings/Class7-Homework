# Internet Gateway
# Allows resources in public subnets to access the internet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "Make-Up-igw"
  }
}

