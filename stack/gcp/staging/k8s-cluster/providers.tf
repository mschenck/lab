terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.21.0"
    }
  }
}

provider "google" {
  project = local.project_id
  region  = local.region
  zone    = local.zones[0]
}

data "google_client_config" "default" {}
