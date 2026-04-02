# terraform {
#   backend "s3" {}
# }

# We are using the local backend for development and testing purposes. 
# In production, we will switch to the S3 backend for better scalability and reliability.
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
