locals {
  vpc_name = "staging"
  services = ["tcpecho"]
  key_name = "windows-ubuntu"
}

// Container Registry
module "registry" {
  source   = "../../modules/registry"
  for_each = toset(local.services)
  name     = each.key
}

module "k8s" {
  source = "../../modules/k8s"

  key_name = local.key_name
  vpc_name = local.vpc_name
}


output "vpc" {
  value = module.k8s.vpc
}

output "aws_subnets" {
  value = module.k8s.aws_subnets
}

output "cluster_name" {
  value = module.k8s.cluster_name
}

output "endpoint" {
  value = module.k8s.endpoint
}

output "ca_data" {
  value = module.k8s.ca_data
}

output "token" {
  value = module.k8s.token
}
