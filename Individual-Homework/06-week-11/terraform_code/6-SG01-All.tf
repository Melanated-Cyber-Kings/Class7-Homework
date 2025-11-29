# Security group for Production Application Servers. 
resource "aws_security_group" "ASG01-sg01-servers" {
  name        = "ASG01-sg01-servers"
  description = "Allow SSH and HTTP traffic to production servers"
  vpc_id      = aws_vpc.demo.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "ASG01-sg01-servers"
    Service = var.service
    Owner   = var.owner
    Planet  = var.planet
  }
}


# Security Group for Load Balancer. 

resource "aws_security_group" "ASG01-sg02-LB01" {
  name        = "ASG01-sg02-LB01"
  description = "Allow HTTP inbound traffic to Load Balancer."
  vpc_id      = aws_vpc.demo.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "ASG01-sg02-LB01"
    Service = var.service
    Owner   = var.owner
    Planet  = var.planet
  }
}
