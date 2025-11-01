resource "aws_instance" "bastion" {

  subnet_id = aws_subnet.us-east-1a-public-subnet.id
  ami                     = "ami-0f9c6511313201a5b"
  instance_type           = "t3.large"
  availability_zone = "us-east-1a"
  associate_public_ip_address = true
  key_name = "MyLinuxBox"
  vpc_security_group_ids = [aws_security_group.hw4_sg-public.id]

  tags = {
      Name    = "hw4-bam-windows-instance"
      Instance = "Windows"
      Os = "Windows"
      Jumpbox = "Bastion"
    }

}



resource "aws_instance" "web" {

  subnet_id = aws_subnet.us-east-1c-private-subnet.id
  ami                     = "ami-0341d95f75f311023"
  instance_type           = "t3.micro"
  availability_zone = "us-east-1c"
  key_name = "MyLinuxBox"
  vpc_security_group_ids = [aws_security_group.hw4_sg-private.id]

  user_data_base64 = base64encode (<<-EOF
#!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Get the IMDSv2 token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Background the curl requests
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
wait

macid=$(cat /tmp/macid)
local_ipv4=$(cat /tmp/local_ipv4)
az=$(cat /tmp/az)
vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$macid/vpc-id)

echo "
<!doctype html>
<html lang=\"en\" class=\"h-100\">
<head>
<title>"Be a man challenge 1.2"
</title>
</head>
<body>
<div>
<h1>"I, Bryant Onojeta, Thank Theo And I.T.Ultimate Study Group, For Teaching Me About Ec2s In Aws. One Step Closer To Escaping Keisha!"
"With This Class, I Will Net 300k Per Year!"</h1>
<h1>"I found my Lil Biach on a party yacht in Brasil! Her name is Caroline!"</h1>

<br>
<img src="https://images.pexels.com/photos/4029987/pexels-photo-4029987.jpeg" alt="Party Yacht" width="600" height="600">  
<br>

<p><b>Instance Name:</b> $(hostname -f) </p>
<p><b>Instance Private Ip Address: </b> $local_ipv4</p>
<p><b>Availability Zone: </b> $az</p>
<p><b>Virtual Private Cloud (VPC):</b> $vpc</p>
</div>
</body>
</html>
" > /var/www/html/index.html

# Clean up the temp files
rm -f /tmp/local_ipv4 /tmp/az /tmp/macid
  EOF

  )

  
  tags = {
      Name    = "hw4-bam-linux-instance"
      Instance = "Linux Web Server"
      Os = "Linux"
    }
}



