terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.43.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.3.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
