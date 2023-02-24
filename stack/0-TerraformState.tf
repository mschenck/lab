variable "tf_state_vendor" {
  description = "The provider to use for storing shared Terraform state."
  type        = string
  validation {
    condition     = contains(["AWS", "GCP"], var.tf_state_vendor)
    error_message = "Must be one of: [AWS, GCP]"
  }
}

variable "tf_state_name" {
  description = "The name used to identify resources as TF state component(s)"
  type        = string
}

# Tier 0 - Terraform State
module "TerraformState" {
  source = "./0-TerraformState"
  vendor = var.tf_state_vendor
  name   = var.tf_state_name

  # Only used when "vendor" set to "GCP"
  gcp_project = var.gcp_project
  gcp_region  = var.gcp_region
}

# Terraform state configuration
