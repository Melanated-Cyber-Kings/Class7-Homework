output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = "This is the DNS name of the Loadbalancer ${aws_lb.app1_alb.dns_name}, accessible over HTTP on port 80"
}       

output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = "The ASG name is : ${aws_autoscaling_group.makeup-asg.name}. Use this to monitor and manage your instances."
}

output "region" {
  description = "The AWS region where resources are deployed"
  value       = "Check in the Console under Region: ${aws_vpc.main.region} for all of the deployed resources"
}

