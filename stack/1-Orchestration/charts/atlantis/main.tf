# # Load k8s credentials

provider "helm" {
  kubernetes {
    config_path = "/tmp/lab-stack-orchestration-cluster.kubeconfig"
  }
}

provider "kubernetes" {
  config_path = "/tmp/lab-stack-orchestration-cluster.kubeconfig"
}

# Install Orchestration Helm charts

module "charts_installation" {
  source = "../../../modules/helm"

  for_each = var.helm_charts

  helm_chart_name    = each.key
  helm_repository    = each.value["chart_url"]
  helm_chart_version = each.value["chart_version"]

  install_name      = each.value["install_name"]
  install_namespace = each.value["install_namespace"]
  install_labels    = each.value["install_labels"]

  k8s_endpoint       = "module.Orchestration.endpoint"
  k8s_ca_certificate = "base64decode(module.Orchestration.aws_ca_data)"
  k8s_token          = "module.Orchestration.token"

  values_files = [
    "${file("values.yaml")}"
  ]

  # depends_on = [
  #   module.Orchestration
  # ]
}
