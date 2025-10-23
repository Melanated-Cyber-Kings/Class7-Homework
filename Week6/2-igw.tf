
resource "aws_internet_gateway" "igw" {
  vpc_id   = aws_vpc.hw4-bastion-bam.id

  tags = {
    Name = "HW4-Bastion Internet Gateway"
  }
}
