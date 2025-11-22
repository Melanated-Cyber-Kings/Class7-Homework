resource "aws_autoscaling_group" "makeup-asg" {
  name_prefix           = "makeup-auto-scaling-group"
  min_size              = 1
  max_size              = 6
  desired_capacity      = 3
  vpc_zone_identifier   = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id,
    aws_subnet.private_3.id
  ]
  health_check_type          = "ELB"
  health_check_grace_period  = 300
  force_delete               = true
  target_group_arns          = [aws_lb_target_group.makeup-tg.arn]


  launch_template {
    id      = aws_launch_template.makeup_lt.id
    version = "$Latest"
  }


  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]


  # Instance protection for launching
  initial_lifecycle_hook {
    name                  = "instance-protection-launch"
    lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
    default_result        = "CONTINUE"
    heartbeat_timeout     = 60
    notification_metadata = "{\"key\":\"value\"}"
  }


  # Instance protection for terminating
  initial_lifecycle_hook {
    name                  = "scale-in-protection"
    lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
    default_result        = "CONTINUE"
    heartbeat_timeout     = 300
  }


  tag {
    key                 = "Name"
    value               = "makeup-instance"
    propagate_at_launch = true
  }


  tag {
    key                 = "Environment"
    value               = "Production"
    propagate_at_launch = true
  }
}


### Auto Scaling Policy
resource "aws_autoscaling_policy" "makeup-scaling-policy" {
  name                   = "makeup-cpu-target"
  autoscaling_group_name = aws_autoscaling_group.makeup-asg.name


  policy_type = "TargetTrackingScaling"
  estimated_instance_warmup = 120


  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0
  }
}


### Enabling Instance Scale-In Protection
resource "aws_autoscaling_attachment" "makeup-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.makeup-asg.name
  lb_target_group_arn   = aws_lb_target_group.makeup-tg.arn
}


