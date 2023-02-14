locals {
  services      = ["tcpecho"]
  architectures = ["ARM 64", "x86-64"]
}

// Container Registry
module "registry" {
  source        = "../../modules/registry"
  architectures = local.architectures
  for_each      = toset(local.services)
  name          = each.key
}
