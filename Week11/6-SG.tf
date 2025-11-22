resource "aws_security_group" "makeup_sg" {
  name        = "allow_web_ssh_sg"
  description = "Allow inbound traffic and outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "makeup-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.makeup_sg.id
  cidr_ipv4         = "0.0.0.0/0"           # Allow from anywhere
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.makeup_sg.id             
  cidr_ipv4         = "0.0.0.0/0"          # Allow from anywhere       
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.makeup_sg.id
  cidr_ipv4         = "0.0.0.0/0"        # Allow to anywhere
  ip_protocol       = "-1" # semantically equivalent to all ports

}



# resource "aws_security_group" "makeup_lb_sg" {
#   vpc_id   = aws_vpc.main.id
#   name     = "makup_lb_sg"
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "Makeup LB Security Group"
#   }
# }


resource "aws_security_group" "allow_http_lb" {
  name        = "allow_http_lb"
  description = "Allow LB Http inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_http_lb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_lb" {
  security_group_id = aws_security_group.allow_http_lb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_http_lb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
