resource "google_project_iam_member" "cluster_service_account-log_writer" {
  project = var.project_id
  member  = "serviceAccount:${google_service_account.cluster_service_account.email}"
  role    = "roles/logging.logWriter"
}

resource "google_project_iam_member" "cluster_service_account-metric_writer" {
  project = var.project_id
  member  = "serviceAccount:${google_service_account.cluster_service_account.email}"
  role    = "roles/monitoring.metricWriter"
}

resource "google_project_iam_member" "cluster_service_account-monitoring_viewer" {
  project = var.project_id
  member  = "serviceAccount:${google_service_account.cluster_service_account.email}"
  role    = "roles/monitoring.viewer"
}

resource "google_project_iam_member" "cluster_service_account-resourceMetadata-writer" {
  project = var.project_id
  member  = "serviceAccount:${google_service_account.cluster_service_account.email}"
  role    = "roles/stackdriver.resourceMetadata.writer"
}
