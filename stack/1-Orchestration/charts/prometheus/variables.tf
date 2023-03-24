variable "repository" {
  default = "https://prometheus-community.github.io/helm-charts"
}

variable "chart_name" {
  default = "prometheus"
}

variable "chart_version" {
  default = "20.0.1"
}

variable "install_labels" {
  description = "K8s labels to apply to installation"
  type        = map(string)
  default     = {}
}
