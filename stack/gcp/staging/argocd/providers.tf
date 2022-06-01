data "google_client_config" "provider" {}

data "google_container_cluster" "gke_cluster" {
  project  = local.project_id
  name     = local.k8s_cluster_name
  location = local.location
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.gke_cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate,
  )
}

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.gke_cluster.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate,
    )
  }
}
