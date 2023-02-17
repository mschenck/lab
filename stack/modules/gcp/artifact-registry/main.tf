resource "google_artifact_registry_repository" "artifact_registry" {
  provider = google-beta

  location      = var.region
  repository_id = var.repository_id
  format        = var.repository_format
  project       = var.project_id
}
