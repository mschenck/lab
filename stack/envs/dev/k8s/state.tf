terraform {
  backend "s3" {
    bucket = "proxmox-stack-tfstate"
    key    = "terraform-containers"
    region = "us-east-1"

    dynamodb_table = "proxmox-stack-tflocking"
  }
}
