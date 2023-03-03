output "endpoint" {
  sensitive = true

  value = module.Orchestration.endpoint
}

output "token" {
  sensitive = true

  value = module.Orchestration.token
}

output "ca_data" {
  sensitive = true

  value = module.Orchestration.ca_data
}
