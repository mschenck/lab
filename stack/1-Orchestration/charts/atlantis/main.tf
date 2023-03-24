# # Load k8s credentials

provider "helm" {
  kubernetes {
    config_path = "/tmp/lab-stack-orchestration-cluster.kubeconfig"
  }
}

provider "kubernetes" {
  config_path = "/tmp/lab-stack-orchestration-cluster.kubeconfig"
}

# Install Atlantis Helm chart

module "atlantis" {
  source = "../../../modules/helm"

  helm_chart_name    = var.chart_name
  helm_repository    = var.repository
  helm_chart_version = var.chart_version

  install_name      = "atlantis"
  install_namespace = "atlantis"
  install_labels    = var.install_labels

  values_files = [
    "${file("values.yaml")}"
  ]
}
