output "TerraformState_config" {
  value = flatten(module.TerraformState.state_config)[0]
}
