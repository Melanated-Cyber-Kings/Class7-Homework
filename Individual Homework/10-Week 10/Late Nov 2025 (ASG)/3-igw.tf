resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.SofiaS.id

  tags = {
    Name    = "SofiaS_IGW"
    Service = "application1"
    Owner   = "Luke"
    Planet  = "Musafar"
  }
}