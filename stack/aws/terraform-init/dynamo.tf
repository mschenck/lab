resource "aws_dynamodb_table" "tflocking" {
  name         = "stack-tflocking"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
