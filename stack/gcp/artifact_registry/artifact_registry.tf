resource "google_artifact_registry_repository" "artifact_registry" {
  provider = google-beta

  location          = var.region
  repository_id     = var.repository_id
  repository_format = var.repository_format
}
