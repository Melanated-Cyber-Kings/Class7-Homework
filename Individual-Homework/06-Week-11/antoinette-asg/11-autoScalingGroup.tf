# Defines ASG
resource "aws_autoscaling_group" "antoinette_asg" {
  name_prefix = "${var.env_prefix}-asg-"

  launch_template {
    id      = aws_launch_template.antoinette_launch_template.id
    version = aws_launch_template.antoinette_launch_template.latest_version
  }

  min_size                  = 1
  max_size                  = 6
  desired_capacity          = var.asg_desired_capacity 
  default_cooldown          = 300
  health_check_type         = "ELB"
  health_check_grace_period = 300
  force_delete              = true

  vpc_zone_identifier = [
    aws_subnet.private-eu-west-3a.id,
    aws_subnet.private-eu-west-3b.id,
    aws_subnet.private-eu-west-3c.id
  ]

  target_group_arns = [
    aws_lb_target_group.tg_1.arn
  ]

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

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 60
    }
  }

  # Applies Name tag to instances launched by ASG
  tag {
    key                 = "Name"
    value               = "${var.env_prefix}-instance-from-asg"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }
}

# Defines Auto Scaling Policy based on CPU Utilization
resource "aws_autoscaling_policy" "cpu_scaling_policy" {
  name                   = "${var.env_prefix}-cpu-scaling-policy"
  autoscaling_group_name = aws_autoscaling_group.antoinette_asg.name
  policy_type            = "TargetTrackingScaling"
  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    
    target_value = 75.0
  }
}