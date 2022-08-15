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

data "aws_s3_bucket" "upload" {
  bucket = var.upload_bucket_name
}

data "aws_s3_bucket" "target" {
  bucket = var.target_bucket_name
}
