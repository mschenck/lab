resource "google_storage_bucket" "tfstate" {
  name          = var.name
  location      = var.region
  force_destroy = true

  versioning {
    enabled = true
  }
}
