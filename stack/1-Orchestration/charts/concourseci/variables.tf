
variable "repository" {
  default = "https://concourse-charts.storage.googleapis.com/"
}

variable "chart_name" {
  default = "concourse"
}

variable "chart_version" {
  default = "17.1.0"
}

variable "install_labels" {
  description = "K8s labels to apply to installation"
  type        = map(string)
  default     = {}
}
