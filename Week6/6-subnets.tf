#### Creating the Public Subnets section ############

resource "aws_subnet" "us-east-1a-public-subnet" {
  vpc_id     = aws_vpc.hw4-bastion-bam.id        # Reference to the VPC created above
  availability_zone = "us-east-1a"  # Specify the availability zone)
  cidr_block = "10.55.2.0/24"

  tags = {
    Name = "us-east-1a-public-subnet"
  }
}

resource "aws_subnet" "us-east-1b-public-subnet" {
  vpc_id     = aws_vpc.hw4-bastion-bam.id        # Reference to the VPC created above
  availability_zone = "us-east-1b"  # Specify the availability zone)
  cidr_block = "10.55.4.0/24"

  tags = {
    Name = "us-east-1b-public-subnet"
    
  }
}

resource "aws_subnet" "us-east-1c-public-subnet" {
  vpc_id     = aws_vpc.hw4-bastion-bam.id        # Reference to the VPC created above
  availability_zone = "us-east-1c"  # Specify the availability zone)
  cidr_block = "10.55.6.0/24"

  tags = {
    Name = "us-east-1c-public-subnet"
   
  }
}

#### Creating Private Subnets section ############

resource "aws_subnet" "us-east-1a-private-subnet" {
  vpc_id     = aws_vpc.hw4-bastion-bam.id          # Reference to the VPC created above
  availability_zone = "us-east-1a"                 # Specify the availability zone)
  cidr_block = "10.55.12.0/24"

  tags = {
    Name = "us-east-1a-private-subnet"
  }
} 
resource "aws_subnet" "us-east-1b-private-subnet" {
  vpc_id     = aws_vpc.hw4-bastion-bam.id           # Reference to the VPC created above
  availability_zone = "us-east-1b"                  # Specify the availability zone)
  cidr_block = "10.55.14.0/24"

  tags = {
    Name = "us-east-1b-private-subnet"
  }
}

 
resource "aws_subnet" "us-east-1c-private-subnet" {
  vpc_id     = aws_vpc.hw4-bastion-bam.id           # Reference to the VPC created above
  availability_zone = "us-east-1c"                  # Specify the availability zone)
  cidr_block = "10.55.16.0/24"

  tags = {
    Name = "us-east-1c-private-subnet"
  }
}



# Output's section

output "vpc_id" {
  description = "ID of BAM Homework VPC"
  value       = aws_vpc.hw4-bastion-bam.id
}

output "us-east-1a-public-subnet-cidr-block" {
  description = "ID of BAM Public Subnet CIDr Block"
  value       = aws_subnet.us-east-1a-public-subnet.cidr_block
}

output "us-east-1a-private-subnet-cidr-block" {
  description = "ID of BAM Private Subnet CIDr Block"
  value       = aws_subnet.us-east-1a-private-subnet.cidr_block
}