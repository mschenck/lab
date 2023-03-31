
variable "orchestration_name" {
  description = "The name used to identify resources as Orchestration component(s)"
  type        = string
}

# Network settings

variable "nodes_subnet_cidr" {
  description = "Subnet for k8s nodes (kubelets)"
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

variable "ec2_instance_min" {
  type    = number
  default = 1
}

variable "ec2_instance_max" {
  type    = number
  default = 1
}

variable "ec2_instance_desired" {
  type    = number
  default = 1
}

variable "ec2_key_name" {
  description = "AWS keypair name"
  type        = string
}

variable "aws_region" {
  description = "The region of the EKS cluster"
  default     = "us-east-1"
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

# Proxmox-specific variables
variable "proxmox_target_node" {
  description = "Name of node to run k3s VM on."
  type        = string
}

variable "proxmox_vm_template" {
  description = "The name of the VM template to clone (created with Packer)"
  type        = string
}

variable "proxmox_ipv4_addr" {
  type    = string
  default = ""
}

variable "proxmox_ipv4_netmask_bits" {
  description = "IPv4 netmask bits i.e. '24' for /24"
  type        = number
  default     = 24
}

variable "proxmox_ipv4_gw" {
  type    = string
  default = ""
}
