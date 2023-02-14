resource "aws_ecrpublic_repository" "stack" {
  repository_name = var.name

  catalog_data {
    architectures     = var.architectures
    operating_systems = ["Linux"]
  }
}
