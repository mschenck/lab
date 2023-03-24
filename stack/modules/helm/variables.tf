
# chart details

variable "helm_repository" {
  description = "Helm repository URL"
  type        = string
}

variable "helm_chart_name" {
  description = "Name of Helm chart to install"
  type        = string

}

variable "helm_chart_version" {
  description = "Version of Helm chart to install"
  type        = string
}

variable "install_name" {
  description = "K8s name to install chart as"
  type        = string
}

variable "install_namespace" {
  description = "K8s namespace to install chart into"
  type        = string
}

variable "install_labels" {
  description = "K8s labels to apply to installation"
  type        = map(string)
}

variable "values_files" {
  description = "Full path to values.yaml"
  type        = list(string)
  default     = []
}
