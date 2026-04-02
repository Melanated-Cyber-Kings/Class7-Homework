locals {
  prefix = var.project_name
}

data "aws_region" "current" {}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.prefix}-vpc"
  }
}

# -----------------------------
# Public Subnet A
# -----------------------------
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_a
  map_public_ip_on_launch = true
  availability_zone       = var.az_a

  tags = {
    Name = "${local.prefix}-public-a"
  }
}

# -----------------------------
# Public Subnet B
# -----------------------------
resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_b
  map_public_ip_on_launch = true
  availability_zone       = var.az_b

  tags = {
    Name = "${local.prefix}-public-b"
  }
}

# -----------------------------
# Private Subnet A
# -----------------------------
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_a
  availability_zone = var.az_a

  tags = {
    Name = "${local.prefix}-private-a"
  }
}

# -----------------------------
# Private Subnet B
# -----------------------------
resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_b
  availability_zone = var.az_b

  tags = {
    Name    = "${local.prefix}-private-b"
    Project = local.prefix
  }
}

# -----------------------------
# Internet Gateway
# -----------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "${local.prefix}-igw"
    Project = local.prefix
  }
}

# -----------------------------
# Public Route Table
# -----------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "${local.prefix}-public-rt"
    Project = local.prefix
  }
}

# -----------------------------
# Route Table Associations
# -----------------------------
resource "aws_route_table_association" "public_assoc_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_assoc_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# -----------------------------
# NAT Gateway EIP
# -----------------------------
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name    = "${local.prefix}-nat-eip"
    Project = local.prefix
  }
}

# -----------------------------
# NAT Gateway (in Public Subnet A)
# -----------------------------
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name    = "${local.prefix}-nat"
    Project = local.prefix
  }
}

# -----------------------------
# Private Route Table
# -----------------------------
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name    = "${local.prefix}-private-rt"
    Project = local.prefix
  }
}

# -----------------------------
# Private Route Table Associations
# -----------------------------
resource "aws_route_table_association" "private_assoc_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_assoc_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

############################################################
# VPC ENDPOINTS FOR SSM (PRIVATE SUBNETS)
############################################################

resource "aws_security_group" "vpc_endpoints" {
  name        = "${local.prefix}-vpc-endpoints-sg"
  description = "Allow HTTPS for VPC endpoints"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${local.prefix}-vpc-endpoints-sg"
    Project = local.prefix
  }
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]
  security_group_ids = [aws_security_group.vpc_endpoints.id]

  tags = {
    Name    = "${local.prefix}-ssm-endpoint"
    Project = local.prefix
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]
  security_group_ids = [aws_security_group.vpc_endpoints.id]

  tags = {
    Name    = "${local.prefix}-ssmmessages-endpoint"
    Project = local.prefix
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]
  security_group_ids = [aws_security_group.vpc_endpoints.id]

  tags = {
    Name    = "${local.prefix}-ec2messages-endpoint"
    Project = local.prefix
  }
}
