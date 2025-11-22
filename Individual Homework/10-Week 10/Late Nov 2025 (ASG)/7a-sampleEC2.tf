# resource "aws_instance" "public-eu-west-1a" {
#   ami                         = "ami-0025245f3ca0bcc82" # eu w1
#   instance_type               = "t3.micro"
#   vpc_security_group_ids      = [aws_security_group.SofiaS-SG.id]
#   subnet_id                   = aws_subnet.public-eu-west-1a.id
#   associate_public_ip_address = true # unsure if this is needed, if subnet has auto assign public IP enabled




#   user_data = file("stripes_user_data.sh")

#   tags = {
#     Name = "hot-ec2"
#   }
# }