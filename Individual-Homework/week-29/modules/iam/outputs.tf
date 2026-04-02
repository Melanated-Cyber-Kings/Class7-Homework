output "instance_profile_name" {
  value = aws_iam_instance_profile.jenkins_profile.name
}

output "role_name" {
  value = aws_iam_role.jenkins_ec2_role.name
}
