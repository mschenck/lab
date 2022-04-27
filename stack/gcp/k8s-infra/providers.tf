terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.19.0"
    }
  }
}

provider "google" {
  project = "stack-348418"
  region  = "us-central1"
  zone    = "us-central1-c"
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}
