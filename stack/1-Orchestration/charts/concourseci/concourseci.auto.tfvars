
# Orchestration Helm charts

helm_charts = {

  # concourse ci
  "concourse" = {
    "chart_url"         = "https://concourse-charts.storage.googleapis.com/",
    "chart_version"     = "17.1.0",
    "install_name"      = "concourse",
    "install_namespace" = "concourse",
    "install_labels"    = {}
  },

}
