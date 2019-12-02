provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "tf-bucket" {
  bucket = "tf-changedname"
  acl    = "private"
}