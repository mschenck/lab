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

# GCP configuations used by tiers.

variable "gcp_project" {
  description = "The GCP Project ID (typically \"<name>-<some number>\")"
  type        = string
  default     = "<MUST SET>"
}

variable "gcp_region" {
  description = "The region of the terraform state"
  default     = "US-CENTRAL1"
}
