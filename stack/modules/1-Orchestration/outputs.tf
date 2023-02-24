output "endpoint" {
  sensitive = true
  value     = module.gcp-orchestration-cluster[*].endpoint
}

output "client_token" {
  sensitive = true
  value     = module.gcp-orchestration-cluster[*].client_token
}

output "master_auth" {
  sensitive = true
  value     = module.gcp-orchestration-cluster[*].master_auth
}

output "service_account" {
  #sensitive = true
  value = module.gcp-orchestration-cluster[*].service_account
}
