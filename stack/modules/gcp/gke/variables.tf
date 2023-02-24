variable "cluster_name" {
  description = "The name of the k8s cluster"
}

variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "location" {
  description = "The region or zone of the k8s cluster"
  type        = string
}

# Auth
variable "service_account_name" {
  description = "RFC1035 compatible name for the k8s service account"
  type        = string
}


# Compute
variable "node_pool_name" {
  description = "Name for the initial node pool"
  type        = string
}

variable "min_node_count" {
  description = "Minimum number of nodes"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "Instance type for cluster nodes"
  default     = "e2-micro"
}


# Network
variable "network_name" {
  description = "The name of the k8s network"
  type        = string
}

variable "subnetwork_name" {
  description = "The name of the k8s subnet"
  type        = string
}

variable "pods_subnet_name" {
  description = "The ip range cidr to use for pods"
  type        = string
}

variable "svcs_subnet_name" {
  description = "The ip range cidr to use for services"
  type        = string
}
