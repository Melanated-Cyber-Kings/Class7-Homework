output "alb_sg_id" {
  description = "Security group ID for ALB"
  value       = aws_security_group.alb.id
}

output "jenkins_sg_id" {
  description = "Security group ID for Jenkins EC2"
  value       = aws_security_group.jenkins.id
}
