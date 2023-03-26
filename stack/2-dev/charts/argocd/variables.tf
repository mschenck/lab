
variable "repository" {
  default = "https://argoproj.github.io/argo-helm"
}

variable "chart_name" {
  default = "argo-cd"
}

variable "chart_version" {
  default = "5.27.3"
}

variable "install_labels" {
  description = "K8s labels to apply to installation"
  type        = map(string)
  default     = {}
}
