resource "aws_instance" "bastion_host" {
  ami           = var.bastion_ami_id
  instance_type = var.bastion_instance_type

  # Places bastion in public 'a' subnet
  subnet_id = aws_subnet.public-eu-west-3a.id
  # Public IP to be able to connect to it
  associate_public_ip_address = true

  # Attaches key and sg
  key_name               = aws_key_pair.bastion_key.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  
  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "${var.env_prefix}-bastion-host"
  }
}