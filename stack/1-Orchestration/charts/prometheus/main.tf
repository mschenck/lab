# Load k8s credentials

provider "helm" {
  kubernetes {
    config_path = "/tmp/lab-stack-orchestration-cluster.kubeconfig"
  }
}

provider "kubernetes" {
  config_path = "/tmp/lab-stack-orchestration-cluster.kubeconfig"
}

# Install Prometheus Helm chart

module "prometheus" {
  source = "../../../modules/helm"

  helm_chart_name    = var.chart_name
  helm_repository    = var.repository
  helm_chart_version = var.chart_version

  install_name      = "prometheus"
  install_namespace = "prometheus"
  install_labels    = var.install_labels

  values_files = [
    "${file("values.yaml")}"
  ]
}
