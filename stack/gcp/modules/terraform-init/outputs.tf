output "bucket" {
  value = google_storage_bucket.tfstate.name
}

output "region" {
  value = google_storage_bucket.tfstate.location
}