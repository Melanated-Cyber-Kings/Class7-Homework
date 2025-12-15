resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.website.bucket
  key    = "index.html"
  source = "./lab-data/index.html"
  content_type = "text/html"

  etag = filemd5("./lab-data/index.html")
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.website.bucket
  key    = "error.html"
  source = "./lab-data/error.html"
  content_type = "text/html"

  etag = filemd5("./lab-data/error.html")
}

resource "aws_s3_object" "image" {
  bucket = aws_s3_bucket.website.bucket
  key    = "fatima.JPG"
  source = "./lab-data/fatima.JPG"
  content_type = "image/jpeg"

  etag = filemd5("./lab-data/fatima.JPG")
}