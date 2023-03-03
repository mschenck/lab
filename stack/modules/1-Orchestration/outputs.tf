output "endpoint" {
  sensitive = true

  value = var.vendor == "GCP" ? module.gcp-orchestration-cluster[*].endpoint : module.aws-orchestration-cluster[*].endpoint
}

output "token" {
  sensitive = true

  value = var.vendor == "GCP" ? module.gcp-orchestration-cluster[*].client_token : module.aws-orchestration-cluster[*].token
}

output "auth_user" {
  sensitive = true

  value = var.vendor == "GCP" ? module.gcp-orchestration-cluster[*].auth_user : module.aws-orchestration-cluster[*].auth_user
}

output "ca_data" {
  sensitive = true

  value = var.vendor == "AWS" ? module.aws-orchestration-cluster[*].ca_data : module.gcp-orchestration-cluster[*].ca_data
}

# GCP-specific outputs

# output "gcp_master_auth" {
#   sensitive = true

#   value = var.vendor == "GCP" ? module.gcp-orchestration-cluster[*].master_auth : [{ "account_id" = "None" }]
# }

# output "gcp_service_account" {
#   #sensitive = true
#   value = var.vendor == "GCP" ? module.gcp-orchestration-cluster[*].service_account : [{ "account_id" = "None" }]
# }
