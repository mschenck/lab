# Load k8s credentials

provider "helm" {
  kubernetes {
    config_path = "/tmp/lab-stack-dev-cluster.kubeconfig"
  }
}

provider "kubernetes" {
  config_path = "/tmp/lab-stack-dev-cluster.kubeconfig"
}

# Install ArgoCD Helm chart

module "argocd" {
  source = "../../../modules/helm"

  helm_chart_name    = var.chart_name
  helm_repository    = var.repository
  helm_chart_version = var.chart_version

  install_name      = "argocd"
  install_namespace = "argocd"
  install_labels    = var.install_labels

  values_files = [
    "${file("values.yaml")}"
  ]
}
