variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "region" {
  description = "The region of the k8s cluster"
}

variable "zones" {
  type        = list(string)
  description = "The zones for the k8s cluster"
}

variable "repository_id" {
  description = "ID for artifact repository"
}

variable "repository_format" {
  type        = string
  description = "ID for artifact repository"

  validation {
    condition = contains(["DOCKER", "MAVEN", "NPM", "PYTHON", "APT", "YUM", "HELM"], var.repository_format)
    error_message = "The repository_format must be one of the supported_formats."
  }
}
