
# Orchestration Helm charts

helm_charts = {

  # Terraform CD
  "atlantis" = {
    "chart_url"         = "https://runatlantis.github.io/helm-charts",
    "chart_version"     = "4.10.3",
    "install_name"      = "atlantis",
    "install_namespace" = "atlantis",
    "install_labels"    = {}
  },

}
