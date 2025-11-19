resource   "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.antoinette-vpc.id

  tags = {
    Name = "${var.env_prefix}-igw"
    Service = "application1"
    Owner = "Lord Hoth"
    Planet = "Kaal"
  }
}