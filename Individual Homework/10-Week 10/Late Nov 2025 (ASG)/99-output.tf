output "lb-url" {
  value = "http://${aws_lb.web-tier.dns_name}"
}