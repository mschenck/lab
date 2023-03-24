
# Helm

variable "helm_charts" {
  description = "Map of charts to install, where key = chart name, values = map of attributes from stack/modules/helm"
  type = map(object({
    chart_url         = string,
    chart_version     = string,
    install_name      = string,
    install_namespace = string,
    install_labels    = map(string)
  }))
}
