output "bucket" {
  value = google_storage_bucket.tfstate.name
}

output "region" {
  value = google_storage_bucket.tfstate.location
}

output "state_config" {
  value = <<EOHCL
terraform {
    backend "gcs" {
        prefix = "FILL THIS IN"

        bucket = "${google_storage_bucket.tfstate.name}"
    }
}
    EOHCL
}
