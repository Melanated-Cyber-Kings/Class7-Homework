output "website_endpoint" {
  description = "The name of the S3 bucket"
  value       = "http://${aws_s3_bucket_website_configuration.website_config.website_endpoint}"
}


output "bucket_info" {
  description = "The name of the S3 bucket"
  value       = {
    name = aws_s3_bucket.website.id
    arn = aws_s3_bucket.website.arn
  }
}

