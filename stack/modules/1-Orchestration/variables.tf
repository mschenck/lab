variable "vendor" {
  description = "The provider to use for storing shared Terraform state."
  type        = string
  validation {
    condition     = contains(["AWS", "GCP"], var.vendor)
    error_message = "Must be one of: [AWS, GCP]"
  }
}

# Common attributes

variable "cluster_name" {
  description = "The name used to identify Orchestration cluster"
  type        = string
}

variable "network_name" {
  description = "The name used to identify Orchestration network"
  type        = string
}

variable "cidr_block" {
  description = "The name of the vpc"
  default     = "10.0.0.0/16"
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

# AWS-specific settings

variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "number_azs" {
  description = "The number of AZs for this VPC. (up to the max for given AWS region)"
  default     = 3
  type        = number
}

variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ec2_key_name" {
  description = "AWS keypair name"
  type        = string
}

variable "instance_tenancy" {
  default = "default"
  type    = string
}

variable "enable_dns_hostnames" {
  default = true
  type    = bool
}

variable "map_public_ips" {
  default = false
  type    = bool
}


# GCP-specific settings

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

## GCP Network settings
variable "gcp_subnetwork_name" {
  description = "The name of the k8s subnet"
}

variable "gcp_pods_subnet_name" {
  description = "The ip range cidr to use for pods"
  type        = string
  default     = "k8s-pods-subnet"
}

variable "gcp_svcs_subnet_name" {
  description = "The ip range cidr to use for services"
  type        = string
  default     = "k8s-svcs-subnet"
}

## GCP Compute settings
variable "gcp_node_pool_name" {
  description = "Name for the initial node pool"
  type        = string
}

variable "gcp_machine_type" {
  description = "Instance type for cluster nodes"
  default     = "e2-micro"
}
