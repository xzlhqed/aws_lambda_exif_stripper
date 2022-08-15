variable "lambda_iam_role_name" {
  type = string
  default = "lambda_s3_iam_role"
}

variable "lambda_iam_policy_name" {
  type = string
  default = "lambda_s3_iam_policy"
}

variable "lambda_function_name" {
  type = string
  default = "exif_stripper"
}

variable "runtime" {
  type = string
  default = "python3.9"
}

variable "target_bucket_name" {
  type = string
  default = "gel-test-bucket-target"
}

variable "upload_bucket_name" {
  type = string
  default = "gel-test-bucket-upload"
}
