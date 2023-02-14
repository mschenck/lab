locals {
  name   = "stack-staging-tfstate"
  region = "US-CENTRAL1"
}

# Comment this out for first creation
terraform {
  backend "gcs" {
    bucket = "stack-staging-tfstate"
    prefix = "staging/init"
  }
}

module "state-init" {
  source = "../../../modules/gcp/terraform-init"

  name   = local.name
  region = local.region
}
