
variable "vendor" {
  description = "The provider to use for storing shared Terraform state."
  type        = string
  validation {
    condition     = contains(["AWS", "GCP"], var.vendor)
    error_message = "Must be one of: [AWS, GCP]"
  }
}

# Common attributes

variable "name" {
  description = "The name used to identify resources as TF state component(s)"
  type        = string
}

# GCP-specific

variable "gcp_region" {
  description = "The region of the terraform state"
  default     = "US-CENTRAL1"
}

variable "gcp_project" {
  description = "The GCP Project ID (typically \"<name>-<some number>\")"
  type        = string
  default     = "<MUST SET>"
}
