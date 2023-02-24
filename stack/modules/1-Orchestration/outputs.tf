output "endpoint" {
  sensitive = true

  value = var.vendor == "GCP" ? module.gcp-orchestration-cluster[*].endpoint : module.aws-orchestration-cluster[*].endpoint
}

output "token" {
  sensitive = true

  value = var.vendor == "GCP" ? module.gcp-orchestration-cluster[*].client_token : module.aws-orchestration-cluster[*].token
}

# AWS-specific outputs

output "aws_ca_data" {
  value = var.vendor == "AWS" ? module.aws-orchestration-cluster[*].ca_data : ["None"]
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
