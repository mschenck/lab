output "endpoint" {
  sensitive = true
  value     = google_container_cluster.primary.endpoint
}

output "client_token" {
  sensitive = true
  value     = base64encode(data.google_client_config.default.access_token)
}

output "master_auth" {
  sensitive = true
  value     = google_container_cluster.primary.master_auth
}

output "service_account" {
  #sensitive = true
  value = google_service_account.cluster_service_account
}

output "role-log_writer" {
  value = google_project_iam_member.cluster_service_account-log_writer
}

output "role-metric_writier" {
  value = google_project_iam_member.cluster_service_account-metric_writer
}

output "role-monitoring_viewer" {
  value = google_project_iam_member.cluster_service_account-monitoring_viewer
}

output "role-resourceMetadata-writer" {
  value = google_project_iam_member.cluster_service_account-resourceMetadata-writer
}
