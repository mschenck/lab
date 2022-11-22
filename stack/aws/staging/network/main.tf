locals {
  vpc_name   = "staging"
  aws_region = "us-east-1"
  cidr_block = "10.0.0.0/16"
  number_azs = 2
  vpc_id     = module.vpc.vpc_id
  subnets    = module.vpc.subnets
  key_name   = "windows-ubuntu"
}

// VPC

module "vpc" {
  source = "../../modules/vpc"

  name       = local.vpc_name
  cidr_block = local.cidr_block
  number_azs = local.number_azs
  aws_region = local.aws_region
}

output "availability_zones" {
  value = module.vpc.availability_zones
}

output "subnets" {
  value = join(", ", tolist(local.subnets[*].availability_zone))
}

// Perimeter

module "perimeter" {
  source = "../../modules/perimeter"

  vpc_id           = local.vpc_id
  key_name         = local.key_name
  number_instances = local.number_azs
  subnets          = local.subnets
}

// Container Registry
module "registry" {
  source = "../../modules/registry"
  name = local.vpc_name
}