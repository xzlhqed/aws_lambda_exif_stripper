resource "aws_iam_user" "read_write_upload" {
  name = var.user_a_name

  tags = {
    permissions = "read-write"
  }
}

resource "aws_iam_access_key" "read_write_upload_key" {
  user = aws_iam_user.read_write_upload.name
}

resource "aws_iam_user_policy" "s3_read_write" {
  name = var.read_write_policy_name
  user = aws_iam_user.read_write_upload.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Effect": "Allow",
      "Resource": "${data.aws_s3_bucket.upload.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_user" "read_only_target" {
  name = var.user_b_name

  tags = {
    permissions = "read-only"
  }
}

resource "aws_iam_access_key" "read_only_target_key" {
  user = aws_iam_user.read_only_target.name
}

resource "aws_iam_user_policy" "s3_read_only" {
  name = var.read_only_policy_name
  user = aws_iam_user.read_only_target.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "${data.aws_s3_bucket.target.arn}"
    }
  ]
}
EOF
}
