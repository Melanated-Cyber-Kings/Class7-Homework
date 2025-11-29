# These are for the public subnets.

# Note: There is only ONE VPC in this architecture.

resource "aws_subnet" "public_zone1" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.public_subnet_cidr_blocks.public_zone1
  availability_zone       = local.zone1
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name    = "public-${local.zone1}"
    Service = var.service
    Owner   = var.owner
    Planet  = var.planet
  }
}

resource "aws_subnet" "public_zone2" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.public_subnet_cidr_blocks.public_zone2
  availability_zone       = local.zone2
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name    = "public-${local.zone2}"
    Service = var.service
    Owner   = var.owner
    Planet  = var.planet
  }
}

resource "aws_subnet" "public_zone3" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = var.public_subnet_cidr_blocks.public_zone3
  availability_zone       = local.zone3
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name    = "public-${local.zone3}"
    Service = var.service
    Owner   = var.owner
    Planet  = var.planet
  }
}



# These are for the private subnets.

resource "aws_subnet" "private_zone1" {
  vpc_id            = aws_vpc.demo.id
  cidr_block        = var.private_subnet_cidr_blocks.private_zone1
  availability_zone = local.zone1

  tags = {
    Name    = "private-${local.zone1}"
    Service = var.service
    Owner   = var.owner
    Planet  = var.planet
  }
}

resource "aws_subnet" "private_zone2" {
  vpc_id            = aws_vpc.demo.id
  cidr_block        = var.private_subnet_cidr_blocks.private_zone2
  availability_zone = local.zone2

  tags = {
    Name    = "private-${local.zone2}"
    Service = var.service
    Owner   = var.owner
    Planet  = var.planet
  }
}


resource "aws_subnet" "private_zone3" {
  vpc_id            = aws_vpc.demo.id
  cidr_block        = var.private_subnet_cidr_blocks.private_zone3
  availability_zone = local.zone3

  tags = {
    Name    = "private-${local.zone3}"
    Service = var.service
    Owner   = var.owner
    Planet  = var.planet
  }
}
