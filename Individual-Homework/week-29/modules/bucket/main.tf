resource "aws_s3_bucket" "jenkins" {
  count  = var.enable_bucket ? 1 : 0
  bucket = "jenkins-${random_id.suffix.hex}"

  lifecycle {
    prevent_destroy = true
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}
