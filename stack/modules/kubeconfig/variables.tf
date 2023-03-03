
variable "ca_certificate" {
  description = "K8s CA Certificate of the cluster to install into (expected to be base64decoded)"
  type        = string
}

variable "endpoint" {
  description = "K8s endpoint of the cluster to install into"
  type        = string

}

variable "cluster_name" {
  description = "The name used to identify the cluster"
  type        = string
}

variable "user" {
  description = "The name of the user or service account"
  type        = string
}

variable "client_token" {
  description = "K8s Client Token"
  type        = string
}
