#builds security group for servers
#multiple ingress rules for port 22 and 80
#outbound rules as usual is left alone

resource "aws_security_group" "app1-sg01-servers" {
  name        = "app1-sg01-servers"
  description = "app1-sg01-servers"
  vpc_id      = aws_vpc.app1.id

  tags = {
    Name    = "app1-sg01-servers"
    Service = "application1"
    Owner   = "Luke"
    Planet  = "Musafar"
  }
}

resource "aws_vpc_security_group_ingress_rule" "myhomepage" {
  security_group_id = aws_security_group.app1-sg01-servers.id
  description       = "MyHomePage"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4       = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.app1-sg01-servers.id
  description       = "SSH"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4       = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.app1-sg01-servers.id
  ip_protocol       = "-1"
  cidr_ipv4       = "0.0.0.0/0"
}



#separate security group for load balancer
resource "aws_security_group" "app1-sg02-LB01" {
  name        = "app1-sg02-LB01"
  description = "app1-sg02-LB01"
  vpc_id      = aws_vpc.app1.id

 tags = {
    Name    = "app1-sg02-LB01"
    Service = "application1"
    Owner   = "Luke"
    Planet  = "Musafar"
  }
 
}
 
resource "aws_vpc_security_group_ingress_rule" "my-load-balancer-homepage" {
  security_group_id = aws_security_group.app1-sg02-LB01.id  
  description       = "My-load-balancer-home-Page"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4       = "0.0.0.0/0"  
  }

resource "aws_vpc_security_group_egress_rule" "load-balancer-all_outbound" {
  security_group_id = aws_security_group.app1-sg02-LB01.id
  ip_protocol       = "-1"
  cidr_ipv4       = "0.0.0.0/0"
}
 

