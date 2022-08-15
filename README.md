# aws lambda exif stripper
terraform modules and python script for stripping EXIF data from images uploaded to s3 bucket

To build, configure aws cli then run `terraform init` -> `terraform plan` -> `terraform apply` in the modules in the following order 
- s3_upload + s3_target
- lambda
- iam_users
