resource "aws_ecr_repository" "stack" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"
}
