terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.26.0"
    }
  }
}

resource "aws_iam_role" "lambda_iam" {
  name = var.lambda_iam_role_name

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

resource "aws_iam_role_policy" "lambda_s3_access" {
  name = var.lambda_iam_policy_name
  role = aws_iam_role.lambda_iam.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "strip_exif_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_iam.arn
  handler       = "stripper.handler"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  runtime = var.runtime

  environment {
    variables = {
      upload_bucket_name = data.aws_s3_bucket.upload.id
      target_bucket_name = data.aws_s3_bucket.target.id
    }
  }
}

resource "aws_s3_bucket_notification" "upload" {
  bucket = data.aws_s3_bucket.upload.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.strip_exif_lambda.arn
    events = ["s3:ObjectCreated:*"]
    filter_suffix = ".jpg"
  }

  depends_on = [aws_lambda_permission.s3_trigger]
}

resource "aws_lambda_permission" "s3_trigger" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.strip_exif_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.upload.arn
}
