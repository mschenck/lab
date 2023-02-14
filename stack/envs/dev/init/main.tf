resource "aws_dynamodb_table" "tflocking" {
  name         = "proxmox-stack-tflocking"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "proxmox-stack-tfstate"
  acl    = "private"

  versioning {
    enabled = true
  }
}
