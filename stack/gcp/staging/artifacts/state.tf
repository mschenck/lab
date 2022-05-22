terraform {
  backend "gcs" {
    bucket  = "stack-tfstate"
    prefix  = "terraform/state"
  }
}