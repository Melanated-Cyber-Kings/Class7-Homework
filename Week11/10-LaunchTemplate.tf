data "aws_ami" "latest-amazon-linux-image"{
    most_recent = true
    owners = ["amazon"]
    filter{
        name = "name"
        values = ["amzn2-ami-kernel-*-x86_64-gp2"]
    }
    filter{
        name = "virtualization-type"
        values = ["hvm"]
    } 
}



resource "aws_launch_template" "makeup_lt" {
  name_prefix   = "app1_LT"
  image_id      = data.aws_ami.latest-amazon-linux-image.id
  instance_type = "t3.micro"
  key_name      = "MyLinuxBox"

  vpc_security_group_ids = [aws_security_group.makeup_sg.id]

  user_data = base64encode(file("./user_data.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "makeup_LT"

    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
