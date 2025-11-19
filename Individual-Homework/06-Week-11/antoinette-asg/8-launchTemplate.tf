resource "aws_launch_template" "antoinette_launch_template" {
  name_prefix   = "antoinette-lt-"
  image_id      = var.web_server_ami_id
  instance_type = var.web_server_instance_type
  user_data     = filebase64("user_data.sh")

  tag_specifications {
    resource_type = "instance"
    tags          = { Name = "${var.env_prefix}-instance" }
  }

 lifecycle {
    create_before_destroy = true
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups = [aws_security_group.web_server_sg.id]
  }
}