terraform {
  backend "s3" {
    bucket = "stack-tfstate"
    key    = "terraform-containers"
    region = "us-east-1"

    dynamodb_table = "stack-tflocking"
  }
}
