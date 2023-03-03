variable "project_name" {
  default = "stack"
}


variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
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

variable "instance_types" {
  type    = string
  default = "t3.micro"
}

variable "instance_desired" {
  type    = number
  default = 1
}

variable "key_name" {
  description = "AWS keypair name"
  type        = string
}

# Network
variable "vpc_name" {
  description = "The name of the vpc"
  type        = string
}

variable "svcs_subnet_cidr" {
  description = "Subnet for k8s services"
  type        = string
}
