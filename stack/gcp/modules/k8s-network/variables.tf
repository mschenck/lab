variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "name" {
  description = "The name of this k8s network"
}


variable "routing_mode" {
  description = "Pass-thru to resouce, see: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network#routing_mode"
  default = "REGIONAL"
}


# Subnets
variable "region" {
  description = "The region of the k8s cluster"
}

variable "vpc_subnet_cidr" {
  description = "The range of internal addresses that are owned by this subnetwork."
  type = string
}

variable "k8s_pods_subnet_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}

variable "k8s_pods_subnet_cidr" {
  description = "The range of internal addresses that are owned by this subnetwork."
  type = string
}

variable "k8s_svcs_subnet_name" {
  description = "The secondary ip range to use for services"
  default     = "ip-range-svcs"
}

variable "k8s_svcs_subnet_cidr" {
  description = "The range of internal addresses that are owned by this subnetwork."
  type = string
}
