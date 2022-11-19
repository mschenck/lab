resource "aws_s3_bucket" "tfstate" {
  bucket = "stack-tfstate"
  acl    = "private"

  versioning {
    enabled = true
  }
}
