output "TerraformState_Directions" {
  value = module.TerraformState.Directions
}

output "TerraformState_config" {
  value = flatten(module.TerraformState.state_config)[0]
}
