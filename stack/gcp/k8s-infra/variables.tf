variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "cluster_name" {
  description = "The name of the k8s cluster"
}

variable "region" {
  description = "The region of the k8s cluster"
}

variable "zones" {
  type        = list(string)
  description = "The zones for the k8s cluster"
}

variable "network_name" {
  description = "The name of the k8s network"
  default     = "gke-network"
}

variable "subnet_name" {
  description = "The name of the k8s subnet"
  default     = "gke-subnet"
}

variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}

variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
  default     = "ip-range-svcs"
}
