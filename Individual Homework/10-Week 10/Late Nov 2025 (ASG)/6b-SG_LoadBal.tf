resource "aws_security_group" "web-load-bal" {
  name        = "web-load-bal"
  description = "Allow HTTP for web ALB"
  vpc_id      = aws_vpc.SofiaS.id

  tags = {
    Name = "web-load-bal"
  }
}


resource "aws_vpc_security_group_ingress_rule" "web-load-bal-ipv4" {
  description       = "HTTP from anywhere"
  security_group_id = aws_security_group.web-load-bal.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

  tags = {
    Name = "HTTP"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_lb" {
  security_group_id = aws_security_group.web-load-bal.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
