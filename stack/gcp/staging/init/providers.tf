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
