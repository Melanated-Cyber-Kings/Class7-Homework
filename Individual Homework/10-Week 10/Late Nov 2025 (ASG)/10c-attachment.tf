# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.asg-test.id
  lb_target_group_arn    = aws_lb_target_group.web-tier.arn
}