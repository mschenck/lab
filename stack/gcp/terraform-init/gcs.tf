resource "google_storage_bucket" "tfstate" {
  name          = "stack-tfstate"
  location      = "US-CENTRAL1"
  force_destroy = true

  versioning {
    enabled = true
  }
}
