variable "orchestration_vendor" {
  description = "The provider to use for storing shared Terraform state."
  type        = string
  validation {
    condition     = contains(["AWS", "GCP"], var.orchestration_vendor)
    error_message = "Must be one of: [AWS, GCP]"
  }
}

variable "orchestration_name" {
  description = "The name used to identify resources as Orchestration component(s)"
  type        = string
}

variable "pods_subnet_cidr" {
  description = "Subnet for k8s pods"
  type        = string
}

variable "svcs_subnet_cidr" {
  description = "Subnet for k8s services"
  type        = string
}

# AWS-specific variables
variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ec2_key_name" {
  description = "AWS keypair name"
  type        = string
}

# GCP-specific variables

variable "gcp_project" {
  description = "The GCP Project ID (typically \"<name>-<some number>\")"
  type        = string
  default     = "<MUST SET>"
}

variable "gcp_region" {
  description = "The region of the orchestration VPC"
  default     = "us-central1"
}

variable "gcp_service_account_name" {
  description = "RFC1035 compatible name for the k8s service account"
  type        = string
}
variable "gke_location" {
  description = "The region/zone of the GKE cluster"
  default     = "us-central1-a"
}
