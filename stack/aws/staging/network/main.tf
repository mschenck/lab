locals {
  vpc_name   = "staging"
  cidr_block = "10.0.0.0/8"
}

module "vpc" {
  source     = "../../modules/vpc"
  vpc_name   = local.vpc_name
  cidr_block = local.cidr_block
}
