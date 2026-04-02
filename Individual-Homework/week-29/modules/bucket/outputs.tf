output "bucket_name" {
  value = var.enable_bucket ? aws_s3_bucket.jenkins[0].bucket : null
}
