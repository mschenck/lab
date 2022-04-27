terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.19.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zones[0]
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}
