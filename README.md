# aws lambda exif stripper
terraform modules and python script for stripping EXIF data from images uploaded to s3 bucket

To build, configure aws cli then run `terraform init` -> `terraform plan` -> `terraform apply` in the modules in the following order 
- s3_upload + s3_target
- lambda
- iam_users

Unfortunately, I believe the python package is misconfigured. While my script works locally, when I began testing in AWS lambda runtime environment I realised I only had access to standard libraries (i.e. not including Pillow) by default. I tried solving this by installing Pillow locally and zipping it with the `stripper.py` script along with a `requirements.txt`, but it doesn't seem to automatically detect this. From what I've seen I believe this is possible with Layers and/or containerising the app locally with Docker, however I couldn't quite figure it out without more research. 

I have had fairly limited experience with creating and implementing lambdas so this was a really fun learning experience!
