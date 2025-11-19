resource "aws_lb" "antoinette_alb" {
  name               = "${var.env_prefix}-alb"
  internal           = false # This is internet-facing
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]


  subnets = [
    aws_subnet.public-eu-west-3a.id, 
    aws_subnet.public-eu-west-3b.id, 
    aws_subnet.public-eu-west-3c.id  
  ]

  enable_deletion_protection = false
  
  tags = {
    Name = "${var.env_prefix}-alb"
  }
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.antoinette_alb.arn
  port              = 80
  protocol          = "HTTP"

  # Default action forwards to target group 1
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_1.arn
  }
}