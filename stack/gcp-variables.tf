
variable "gcp_project" {
  description = "The GCP Project ID (typically \"<name>-<some number>\")"
  type        = string
  default     = "<MUST SET>"
}

variable "gcp_region" {
  description = "The region of the terraform state"
  default     = "US-CENTRAL1"
}
