terraform {
  backend "gcs" {
    bucket  = "stack-tfstate"
    prefix  = "terraform/state"
  }
}

module "k8s-infra" {
  source = "./k8s-infra"

  project_id   = "stack-348418"
  cluster_name = "gke-stack"
  region       = "us-central1"
  zones        = ["us-central1-a"]
}
