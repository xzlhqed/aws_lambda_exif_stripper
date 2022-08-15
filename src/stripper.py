from Pillow import Image
import io
import boto3

def stripper(image):
  image = Image.open(image)

  data = list(image.getdata())

  stripped_image = Image.new(image.mode, image.size)
  stripped_image.putdata(data)

  return stripped_image
  

def handler(event, context):
  s3 = boto3.client('s3')

  path = event['Records'][0]['s3']['object']['key']

  image = s3.get_object(Bucket="gel-test-bucket-upload", Key=path)

  new_image = stripper(image)

  s3.put_object(Bucket="gel-test-bucket-target", Key=path, Body=new_image)

  return {
    'statusCode': 200
  }
