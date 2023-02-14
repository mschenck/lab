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
