locals {
  project_id       = "stack-348418"
  k8s_cluster_name = "staging-gke-cluster"
  location         = "us-central1-a"

  istio_base_namespace    = "istio-system"
  istio_ingress_namespace = "istio-ingress"
  istio_version           = "1.13.4"
  helm_repository         = "https://istio-release.storage.googleapis.com/charts"
}

# Istio - Base
resource "kubernetes_namespace" "istio-base" {
  metadata {
    annotations = {
      name = local.istio_base_namespace
    }

    name = local.istio_base_namespace
  }
}

resource "helm_release" "istio_base" {
  name       = "istio-base"
  chart      = "base"
  version    = local.istio_version
  repository = local.helm_repository
  namespace  = local.istio_base_namespace

  depends_on = [
    kubernetes_namespace.istio-base
  ]
}

resource "helm_release" "istio_istiod" {
  name       = "istio-istiod"
  chart      = "istiod"
  version    = local.istio_version
  repository = local.helm_repository
  namespace  = local.istio_base_namespace


  depends_on = [
    helm_release.istio_base
  ]
}

# Istio - Ingress
resource "kubernetes_namespace" "istio-ingress" {
  metadata {
    annotations = {
      name = local.istio_ingress_namespace
    }

    labels = {
      istio-injection = "enabled"
    }

    name = local.istio_ingress_namespace
  }
}

resource "helm_release" "istio_ingress" {
  name       = "istio-ingress"
  chart      = "gateway"
  version    = local.istio_version
  repository = local.helm_repository
  namespace  = local.istio_ingress_namespace

  depends_on = [
    helm_release.istio_istiod
  ]
}
