# Load k8s credentials

provider "helm" {
  kubernetes {
    config_path = "/tmp/lab-stack-dev-cluster.kubeconfig"
  }
}

provider "kubernetes" {
  config_path = "/tmp/lab-stack-dev-cluster.kubeconfig"
}

# Install grafana Helm chart

module "grafana" {
  source = "../../../modules/helm"

  helm_chart_name    = var.chart_name
  helm_repository    = var.repository
  helm_chart_version = var.chart_version

  install_name      = "grafana"
  install_namespace = "grafana"
  install_labels    = var.install_labels

  values_files = [
    "${file("values.yaml")}"
  ]
}
