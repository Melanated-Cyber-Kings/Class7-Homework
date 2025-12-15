resource "aws_s3_bucket" "website" {
  bucket_prefix = "website-hosting-"
  force_destroy = true
  
  tags = {
    Name        = "Bucket for Website Hosting"
    Environment = "Dev"
  }
}































