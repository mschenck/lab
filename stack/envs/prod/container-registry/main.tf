module "container_registry" {
  source = "../../../modules/gcp/artifact-registry"

  project_id = "stack-348418"
  region     = "us-central1"
  zones      = ["us-central1-a"]

  repository_id     = "container-registry-prod"
  repository_format = "DOCKER"
}
