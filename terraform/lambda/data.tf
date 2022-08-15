terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

data "archive_file" "lambda_zip" {
  type = "zip"
  source_dir = "../../src"
  output_file_mode = 0666
  output_path = "../../stripper.zip"
}

data "aws_s3_bucket" "upload" {
  bucket = var.upload_bucket_name
}

data "aws_s3_bucket" "target" {
  bucket = var.target_bucket_name
}
