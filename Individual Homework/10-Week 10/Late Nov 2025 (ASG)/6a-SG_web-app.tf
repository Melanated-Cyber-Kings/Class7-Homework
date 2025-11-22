resource "aws_security_group" "SofiaS-SG" {
  name        = "SofiaS-SG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.SofiaS.id

  tags = {
    Name = "SofiaS-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "SofiaS-SG_SSH" {
  security_group_id = aws_security_group.SofiaS-SG.id
  description       = "SSH from anywhere"
  cidr_ipv4         = aws_vpc.SofiaS.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name = "SSH"
  }
}


resource "aws_vpc_security_group_ingress_rule" "SofiaS-SG_ipv4" {
  description                  = "HTTP from ALB"
  referenced_security_group_id = aws_security_group.web-load-bal.id
  security_group_id            = aws_security_group.SofiaS-SG.id
  # cidr_ipv4                    = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80

  tags = {
    Name = "HTTP"
  }
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.SofiaS-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
