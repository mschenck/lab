resource "google_service_account" "cluster_service_account" {
  disabled     = false
  display_name = "Terraform-managed service account for cluster gke-stack"
  project      = var.project_id
  account_id   = var.service_account_id
}
