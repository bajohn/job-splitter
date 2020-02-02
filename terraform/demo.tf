provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "tf-bucket" {
  bucket = "tf-changedname"
  acl    = "private"
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

resource "aws_lambda_function" "test_lambda_1" {
  # filename      = "../package.zip"
  # s3_bucket = aws_s3_bucket.tf-bucket.bucket
  # s3_key = "package.zip"
  source_code_hash = filebase64sha256("../out/demo_handler.zip")

  filename      = "../out/demo_handler.zip"
  function_name = "created_by_terraform1"
  role          = aws_iam_role.iam_for_lambda2.arn
  handler       = "demo_handler.handler"

  layers  = ["${aws_lambda_layer_version.lib_layer.arn}"]
  runtime = "python3.7"
  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_function" "test_lambda_3" {
  # filename      = "../package.zip"
  # s3_bucket = aws_s3_bucket.tf-bucket.bucket
  # s3_key = "package.zip"
  source_code_hash = filebase64sha256("../out/demo_handler2.zip")
  filename      = "../out/demo_handler2.zip"
  function_name = "created_by_terraform2"
  role          = aws_iam_role.iam_for_lambda2.arn
  handler       = "demo_handler2.handler"

  layers  = ["${aws_lambda_layer_version.lib_layer.arn}"]
  runtime = "python3.7"
  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_layer_version" "lib_layer" {
  filename   = "../lib.zip"
  layer_name = "libs"

  compatible_runtimes = ["python3.7"]
}
