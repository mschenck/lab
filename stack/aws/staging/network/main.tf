locals {
  vpc_name   = "staging"
  aws_region = "us-east-1"
  cidr_block = "10.0.0.0/16"
  number_azs = 3
}

module "vpc" {
  source     = "../../modules/vpc"
  name       = local.vpc_name
  cidr_block = local.cidr_block
  number_azs = local.number_azs
  aws_region = local.aws_region
}

output "availability_zones" {
  value = "Availability Zones: ${module.vpc.availability_zones}"
}

output "subnets" {
  value = "Subnets: ${module.vpc.subnets}"
}
