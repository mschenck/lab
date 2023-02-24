variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "name" {
  description = "The name of this k8s network"
}

variable "subnetwork_name" {
  description = "The name of the k8s subnet"
}

variable "routing_mode" {
  description = "Pass-thru to resouce, see: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network#routing_mode"
  default     = "REGIONAL"
}


# Subnets
variable "region" {
  description = "The region of the k8s cluster"
}

variable "vpc_subnet_cidr" {
  description = "The range of internal addresses that are owned by this subnetwork."
  type        = string
}

variable "vpc_secondary_ip_range" {
  description = "The secondary ip ranges for this subnetwork"
  type        = list(object({ range_name = string, ip_cidr_range = string }))
}
