#public subnets

resource "aws_subnet" "public-eu-west-3a" {
  vpc_id            = aws_vpc.antoinette-vpc.id
  cidr_block        =  "10.33.1.0/24"
  availability_zone = "${var.aws_region}a" 
       
    tags = {
        Name = "antoinette-public-a"
        Service = "application1"
        Owner = "Lord Hoth"
        Planet = "Kaal"
    }

}

resource "aws_subnet" "public-eu-west-3b" {
  vpc_id            = aws_vpc.antoinette-vpc.id
  cidr_block        =  "10.33.2.0/24"
  availability_zone = "${var.aws_region}b" 
         
        tags = {  
            Name = "antoinette-public-b"
            Service = "application1"
            Owner = "Lord Hoth"
            Planet = "Kaal"
        } 
}

resource "aws_subnet" "public-eu-west-3c" {
  vpc_id            = aws_vpc.antoinette-vpc.id
  cidr_block        =  "10.33.3.0/24"
  availability_zone = "${var.aws_region}c"  
      
        tags = {
            Name = "antoinette-public-c"
            Service = "application1"
            Owner = "Lord Hoth"
            Planet = "Kaal"
        } 
}       


#private subnets
resource "aws_subnet" "private-eu-west-3a" {
  vpc_id            = aws_vpc.antoinette-vpc.id
  cidr_block        =  "10.33.11.0/24"
  availability_zone = "${var.aws_region}a"  
       
    tags = {
        Name = "antoinette-private-a"
        Service = "application1"
        Owner = "Lord Hoth"
        Planet = "Kaal"
    }
}

resource "aws_subnet" "private-eu-west-3b" {
  vpc_id            = aws_vpc.antoinette-vpc.id
  cidr_block        =  "10.33.12.0/24"
    availability_zone = "${var.aws_region}b"
         
          tags = {
                Name = "antoinette-private-b"
                Service = "application1"
                Owner = "Lord Hoth"
                Planet = "Kaal"
          }
}

resource "aws_subnet" "private-eu-west-3c" {
  vpc_id            = aws_vpc.antoinette-vpc.id
  cidr_block        =  "10.33.13.0/24"
    availability_zone = "${var.aws_region}c"  
      
          tags = {
                Name = "antoinette-private-c"
                Service = "application1"
                Owner = "Lord Hoth"
                Planet = "Kaal"
          }
}   