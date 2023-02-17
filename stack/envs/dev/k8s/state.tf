terraform {
  backend "s3" {
    bucket = "proxmox-stack-tfstate"
    key    = "terraform-k8s"
    region = "us-east-1"

    dynamodb_table = "proxmox-stack-tflocking"
  }
}
