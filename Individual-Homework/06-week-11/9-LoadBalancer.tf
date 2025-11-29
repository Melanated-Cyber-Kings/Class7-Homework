resource "aws_lb" "ASG01-LB01" {
  name               = "ASG01-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ASG01-sg02-LB01.id]
  subnets = [
    aws_subnet.public_zone1.id,
    aws_subnet.public_zone2.id,
    aws_subnet.public_zone3.id
  ]
  enable_deletion_protection = false
  #Lots of death and suffering here, make sure it's false

  tags = {
    Name    = "ASG01-LB01"
    Service = var.service
    Owner   = var.owner

  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.ASG01-LB01.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ASG01_TG01.arn
  }
}


output "lb_dns_name" {
  value       = aws_lb.ASG01-LB01.dns_name
  description = "The DNS name of the App1 Load Balancer."
}