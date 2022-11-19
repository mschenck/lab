resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kube-prometheus"
}
