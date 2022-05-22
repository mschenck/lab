locals {
    name   = "stack-prod-tfstate"
    region = "US-CENTRAL1"
}

# Comment this out for first creation
terraform {
  backend "gcs" {
    bucket  = "stack-prod-tfstate"
    prefix  = "prod/init"
  }
}

module "state-init" {
    source = "../../modules/terraform-init"

    name   = local.name
    region = local.region
}