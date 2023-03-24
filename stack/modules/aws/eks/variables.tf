variable "project_name" {
  default = "stack"
}

variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
}

variable "region" {
  default = "us-east-1"
  type    = string
}

variable "number_azs" {
  description = "The number of AZs for this VPC. (up to the max for given AWS region)"
  default     = 3
  type        = number
}

# Compute
variable "node_pool_name" {
  description = "Name for the initial node pool"
  type        = string
}

variable "instance_min" {
  type    = number
  default = 1
}

variable "instance_max" {
  type    = number
  default = 1
}

variable "instance_desired" {
  type    = number
  default = 1
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  description = "AWS keypair name"
  type        = string
}

# Network
variable "network_name" {
  description = "The name of the vpc"
  type        = string
}

variable "cidr_block" {
  description = "The name of the vpc"
  default     = "10.0.0.0/16"
  type        = string
}

variable "svcs_subnet_cidr" {
  description = "Subnet for k8s services"
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
  default = true
  type    = bool
}
