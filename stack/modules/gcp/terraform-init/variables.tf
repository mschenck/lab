variable "name" {
  description = "The name for the given terraform environment"
}

variable "project" {
  description = "The GCP Project ID (typically \"<name>-<some number>\")"
  type        = string
  default     = "<MUST SET>"
}

variable "region" {
  description = "The region of the terraform state"
  default     = "US-CENTRAL1"
}
