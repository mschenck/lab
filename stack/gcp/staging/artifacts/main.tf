module "artifact_registry" {
  source = "./artifact_registry"

  project_id        = "stack-348418"
  region            = "us-central1"
  zones             = ["us-central1-a"]

  repository_id     = "container-registry"
  repository_format = "DOCKER"
}
