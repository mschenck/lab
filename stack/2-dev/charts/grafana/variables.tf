variable "repository" {
  default = "https://grafana.github.io/helm-charts"
}

variable "chart_name" {
  default = "grafana"
}

variable "chart_version" {
  default = "6.52.4"
}

variable "install_labels" {
  description = "K8s labels to apply to installation"
  type        = map(string)
  default     = {}
}
