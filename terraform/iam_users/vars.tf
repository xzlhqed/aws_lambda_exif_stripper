variable "user_a_name" {
  type = string
  default = "user-A"
}

variable "user_b_name" {
  type = string
  default = "user-B"
}

variable "read_write_policy_name" {
  type = string
  default = "read-write-upload"
}

variable "read_only_policy_name" {
  type = string
  default = "read-only-target"
}

variable "target_bucket_name" {
  type = string
  default = "gel-test-bucket-target"
}

variable "upload_bucket_name" {
  type = string
  default = "gel-test-bucket-upload"
}
