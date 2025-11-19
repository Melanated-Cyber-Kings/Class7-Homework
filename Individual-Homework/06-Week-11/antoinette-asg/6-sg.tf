# Security Group - ALB
resource "aws_security_group" "lb_sg" {
  name        = "alb-security-group"
  description = "Allow HTTP traffic to ALB"
  vpc_id      = aws_vpc.antoinette-vpc.id

  ingress {
    description = "Allow HTTP from anywhere"
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

  tags = { Name = "${var.env_prefix}-lb-sg" }
}

# Security Group - Bastion Host
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-host-sg"
  description = "Allow SSH from user" 
  vpc_id      = aws_vpc.antoinette-vpc.id


  ingress {
    description = "Allow SSH from my IP" 
    from_port   = 22                     
    to_port     = 22                     
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.env_prefix}-bastion-sg" }
}

# Security Group - EC2 Instances in ASG
resource "aws_security_group" "web_server_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP from ALB and SSH from Bastion"
  vpc_id      = aws_vpc.antoinette-vpc.id

  ingress {
    description     = "Allow HTTP from the Application Load Balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }
  
  ingress {
    description = "Allow HTTP from within the VPC for Health Checks"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.private-eu-west-3a.cidr_block,
      aws_subnet.private-eu-west-3b.cidr_block,
      aws_subnet.private-eu-west-3c.cidr_block
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.env_prefix}-web-server-sg" }
}

# Standalone Ingress Rule for Bastion access
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_bastion" {
  description                  = "Allow SSH from Bastion"
  security_group_id            = aws_security_group.web_server_sg.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.bastion_sg.id
}