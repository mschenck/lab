terraform {
  backend "gcs" {
    bucket = "stack-staging-tfstate"
    prefix = "staging/argocd"
  }
}
