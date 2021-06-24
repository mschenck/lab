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

    helm = {
      source = "hashicorp/helm"
      version = "2.2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "helm" {
  kubernetes {
    config_path = "./kube.config"
  }
}
