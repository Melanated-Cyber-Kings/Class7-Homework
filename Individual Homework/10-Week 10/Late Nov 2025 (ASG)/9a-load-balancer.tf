resource "aws_lb" "web-tier" {
  name               = "web-tier-alb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web-load-bal.id]
  subnets            = [aws_subnet.public-eu-west-1a.id, aws_subnet.public-eu-west-1b.id, aws_subnet.public-eu-west-1c.id]

  enable_deletion_protection = false

 
  tags = {
   name = "web-tier-alb-tf"
  }
}