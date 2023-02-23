output "bucket" {
  value = aws_s3_bucket.tfstate.id
}

output "region" {
  value = aws_s3_bucket.tfstate.region
}

output "dynamodb_table" {
  value = aws_dynamodb_table.tflocking.id
}

output "state_config" {
  value = <<-EOHCL
    Copy below for terraform state configurations:
    
    terraform {
        backend "s3" {
            key = "FILL THIS IN"

            bucket         = "${aws_s3_bucket.tfstate.id}"
            region         = "${aws_s3_bucket.tfstate.region}"
            dynamodb_table = "${aws_dynamodb_table.tflocking.id}"
        }
    }
    EOHCL
}
