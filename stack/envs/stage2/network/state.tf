terraform {
  backend "s3" {
    bucket = "stack-tfstate"
    key    = "terraform-network"
    region = "us-east-1"

    dynamodb_table = "stack-tflocking"
  }
}
