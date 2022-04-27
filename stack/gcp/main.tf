terraform {
  backend "gcs" {
    bucket  = "stack-tfstate"
    prefix  = "terraform/state"
  }
}

module "k8s-infra" {
  source = "./k8s-infra"

  project_id   = "stack-348418"
  region       = "us-central1"
  zones        = ["us-central1-a"]

  cluster_name = "gke-stack"
}

#module "helm_registry" {
#  source = "./artifact_registry"
#
#  project_id        = "stack-348418"
#  region            = "us-central1"
#  zones             = ["us-central1-a"]
#
#  repository_id     = "helm-registry"
#  repository_format = "HELM"
#}

module "container_registry" {
  source = "./artifact_registry"

  project_id        = "stack-348418"
  region            = "us-central1"
  zones             = ["us-central1-a"]

  repository_id     = "container-registry"
  repository_format = "DOCKER"
}
