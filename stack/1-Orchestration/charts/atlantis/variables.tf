
variable "repository" {
  default = "https://runatlantis.github.io/helm-charts"
}

variable "chart_name" {
  default = "atlantis"
}

variable "chart_version" {
  default = "4.10.3"
}

variable "install_labels" {
  description = "K8s labels to apply to installation"
  type        = map(string)
  default     = {}
}
