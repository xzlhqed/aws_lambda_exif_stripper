# aws lambda exif stripper
terraform modules and python script for stripping EXIF data from images uploaded to s3 bucket

Includes the following terraform modules
- `s3_upload` - creates s3 bucket where images with metadata will be uploaded initially (bucket A)
- `s3_target` - creates s3 bucket where images will be uploaded after having EXIF data stripped (bucket B)
- `lambda`    - creates lambda function with required permissions from the `stripper.py` script in `src` directory, as well as an event trigger so that the   lambda is executed whenever an image is uploaded to the bucket created in `s3_upload`
- `iam_users` - creates iam users as referred to in the brief as `A` and `B`; `A` with r/w access to `s3_upload` bucket and `B` with ro access   to     `s3_target` bucket

`stripper.py` contains the handler for the lambda that will strip EXIF data from uploaded images.

To build, configure aws cli then run `terraform init` -> `terraform plan` -> `terraform apply` in the modules in the following order 
- `s3_upload` + `s3_target`
- `lambda`
- `iam_users`

`s3_upload`, `s3_target` and `lambda` along with the `src` folder consitute part one of the exercise, with `iam_users` module for part two.
