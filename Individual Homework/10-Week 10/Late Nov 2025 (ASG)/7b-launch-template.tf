resource "aws_launch_template" "web-tier" {
  name        = "web-tier-launch-template"
  description = "launch template for web tier servers"

  image_id               = "ami-0025245f3ca0bcc82"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.SofiaS-SG.id]
  user_data              = filebase64("Stripes_user_data.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      name      = "web-tier-server-template"
      managedby = "terraform"
    }
  }

  lifecycle {
    create_before_destroy = true
  }

}