resource "aws_ecr_repository" "stack" {
  name                 = var.project_name
  image_tag_mutability = "MUTABLE"
}
