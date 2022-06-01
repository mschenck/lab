locals {
  project_id       = "stack-348418"
  k8s_cluster_name = "staging-gke-cluster"
  location         = "us-central1-a"

  helm_repository      = "https://argoproj.github.io/argo-helm"
  argocd_version       = "4.8.0"
  kubernetes_namespace = "argocd"
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    annotations = {
      name = local.kubernetes_namespace
    }

    labels = {
      "istio-injection" = "enabled"
    }

    name = local.kubernetes_namespace
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  version    = local.argocd_version
  repository = local.helm_repository
  namespace  = local.kubernetes_namespace

  depends_on = [
    kubernetes_namespace.argocd
  ]
}
