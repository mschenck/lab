terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.40.0"
    }
    proxmox = {
      source  = "telmate/proxmox"
      version = "~> 2.9.13"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "proxmox" {
  pm_debug = true
}
