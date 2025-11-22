resource "aws_autoscaling_group" "asg-test"{
  name = "web-server-asg"
  vpc_zone_identifier = [aws_subnet.private-eu-west-1a.id,
    aws_subnet.private-eu-west-1b.id,
  aws_subnet.private-eu-west-1c.id]

  max_size          = 6
  min_size          = 3
  health_check_type = "ELB"
  target_group_arns = [aws_lb_target_group.web-tier.arn]
  force_delete      = true


  launch_template {
    id      = aws_launch_template.web-tier.id
    version = "$Latest"
  }

  tag {
    key                 = "name"
    value               = "web-instance"
    propagate_at_launch = true
  }
}