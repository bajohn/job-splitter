provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "tf-bucket" {
  bucket = "tf-changedname"
  acl    = "private"
}

data "aws_s3_bucket_object" "lambda_data" {
  bucket = aws_s3_bucket.tf-bucket.bucket
  key    = "package.zip"
}

# the below lambda code hasn't been deployed yet

resource "aws_iam_role" "iam_for_lambda2" {
  name = "iam_for_lambda2"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {
  # filename      = "../package.zip"
  s3_bucket = aws_s3_bucket.tf-bucket.bucket
  s3_key = "package.zip"
  function_name = "created_by_terraform2"
  role          = aws_iam_role.iam_for_lambda2.arn
  handler       = "lambdas/demo_handler.handler"

  runtime = "python3.7"
  source_code_hash = filemd5("../package.zip")# base64encode(data.aws_s3_bucket_object.lambda_data.body)
  environment {
    variables = {
      foo = "bar"
    }
  }
}