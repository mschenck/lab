# This module will configure the resources necessary for storing Terraform state.
# 
# Only one vendor will be implemented, this selection is performed via the "vendor" variable.

# AWS
module "awsstate" {
  source = "../modules/aws/terraform-init"
  name   = var.name

  count = var.vendor == "AWS" ? 1 : 0
}

# GCP
module "gcpstate" {
  source  = "../modules/gcp/terraform-init"
  name    = var.name
  region  = var.gcp_region
  project = var.gcp_project

  count = var.vendor == "GCP" ? 1 : 0
}
