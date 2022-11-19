terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.43.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "stack-tfstate"
    key    = "terraform-container-infra"
    region = "us-east-1"

    dynamodb_table = "stack-tflocking"
  }
}
