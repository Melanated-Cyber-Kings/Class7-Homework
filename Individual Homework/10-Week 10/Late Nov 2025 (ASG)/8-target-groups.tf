resource "aws_lb_target_group" "web-tier" {
  name     = "terraform-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.SofiaS.id

  tags = {
    name = "web-tier-tg"
  }
}

