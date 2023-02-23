# Tier 0 - Terraform State
module "TerraformState" {
  source = "../modules/0-TerraformState"
  vendor = var.tf_state_vendor
  name   = var.tf_state_name

  # Only used when "vendor" set to "GCP"
  gcp_project = var.gcp_project
  gcp_region  = var.gcp_region
}

# Terraform state configuration
