terraform {
  backend "gcs" {
    bucket  = "stack-prod-tfstate"
    prefix  = "prod/container-registry"
  }
}