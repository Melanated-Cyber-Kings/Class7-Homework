resource "aws_security_group" "hw4_sg-public"{
  vpc_id   = aws_vpc.hw4-bastion-bam.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
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
    Name = "HW4-Security Group-public"
    rdp = "3389"
    http = "80"
  }
}

resource "aws_security_group" "hw4_sg-private"{
  vpc_id   = aws_vpc.hw4-bastion-bam.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.hw4-bastion-bam.cidr_block]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.hw4-bastion-bam.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "HW4-Security Group Private"
    ssh = "22"
    http = "80"
  }
}
