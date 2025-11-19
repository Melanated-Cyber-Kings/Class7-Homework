# Target Group 1
resource "aws_lb_target_group" "tg_1" {
  name     = "${var.env_prefix}-tg-1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.antoinette-vpc.id 
  target_type = "instance"

  # Health check settings
  health_check {
    enabled             = true
    path                = "/index.html" 
    protocol            = "HTTP"
    matcher             = "200" 
    interval            = 30
    timeout             = 6
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
  tags = { Name = "${var.env_prefix}-tg-1" }
}

