terraform {
  backend "gcs" {
    bucket  = "stack-staging-tfstate"
    prefix  = "staging/k8s-cluster"
  }
}