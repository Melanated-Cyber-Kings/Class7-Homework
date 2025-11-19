#network layout
#root vpc = 10.25.0.0/16

#pub A = 10.25.1.0/24
#pub B = 10.25.2.0/24
#pub C = 10.25.3.0/24

#priv A = 10.25.11.0/24
#priv B = 10.25.12.0/24
#priv C = 10.25.13.0/24


#These are   for  public

resource "aws_subnet" "public-us-east-2a" {
  vpc_id                  = aws_vpc.app1.id
  cidr_block              = "10.25.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-2a"
    Service = "application1"
    Owner = "ThisGuy"
    Planet  = "Earth"
  }
}

resource "aws_subnet" "public-us-east-2b" {
  vpc_id                  = aws_vpc.app1.id
  cidr_block              = "10.25.2.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-2b"
    Service = "application1"
    Owner = "ThisGuy"
    Planet  = "Earth"
  }
}


resource "aws_subnet" "public-us-east-2c" {
  vpc_id                  = aws_vpc.app1.id
  cidr_block              = "10.25.3.0/24"
  availability_zone       = "us-east-2c"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-2c"
    Service = "application1"
    Owner = "ThisGuy"
    Planet  = "Earth"
  }
}

#these are for private
resource "aws_subnet" "private-us-east-2a" {
  vpc_id            = aws_vpc.app1.id
  cidr_block        = "10.25.11.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name    = "private-us-east-2a"
    Service = "application1"
    Owner = "ThisGuy"
    Planet  = "Earth"
  }
}

resource "aws_subnet" "private-us-east-2b" {
  vpc_id            = aws_vpc.app1.id
  cidr_block        = "10.25.12.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name    = "private-us-east-2b"
    Service = "application1"
    Owner = "ThisGuy"
    Planet  = "Earth"
  }
}


resource "aws_subnet" "private-us-east-2c" {
  vpc_id            = aws_vpc.app1.id
  cidr_block        = "10.25.13.0/24"
  availability_zone = "us-east-2c"

  tags = {
    Name    = "private-us-east-2c"
    Service = "application1"
    Owner = "ThisGuy"
    Planet  = "Earth"
  }
}




