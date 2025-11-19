output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer."
  value       = aws_lb.antoinette_alb.dns_name
}

output "bastion_host_public_ip" {
  description = "The public IP address of the Bastion Host."
  value       = aws_instance.bastion_host.public_ip
}