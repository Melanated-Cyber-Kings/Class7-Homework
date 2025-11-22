resource "aws_security_group" "terraform-sg" {
  name        = "terraform-sg"
  description = "Allow inbound traffic and all outbound traffic to terraform vpc"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "terraform-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "terraform-sg-ssh_ipv4" {
  description = "SSH from anywhere"
  security_group_id = aws_security_group.terraform-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

## tags to name the security group rule
   tags = {
     Name = "SSH"
   }
}

resource "aws_vpc_security_group_ingress_rule" "terraform-sg-http_ipv4" {
  description = "HTTP from anywhere"
  security_group_id = aws_security_group.terraform-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

## tags to name the security group rule
   tags = {
     Name = "HTTP"
   }
}

resource "aws_vpc_security_group_egress_rule" "terraform-sg_traffic_ipv4" {
  security_group_id = aws_security_group.terraform-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }