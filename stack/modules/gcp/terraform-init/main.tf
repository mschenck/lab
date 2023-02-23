resource "google_storage_bucket" "tfstate" {
  name          = "${var.name}-tfstate"
  location      = var.region
  force_destroy = true
  project       = var.project

  versioning {
    enabled = true
  }
}
