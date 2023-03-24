resource "kubernetes_namespace" "helm_namespace" {
  metadata {
    annotations = {
      name = var.install_namespace
    }

    labels = var.install_labels

    name = var.install_namespace
  }
}

resource "helm_release" "helm_installation" {
  name       = var.install_name
  chart      = var.helm_chart_name
  version    = var.helm_chart_version
  repository = var.helm_repository
  namespace  = var.install_namespace
  values     = var.values_files

  depends_on = [
    kubernetes_namespace.helm_namespace
  ]
}
