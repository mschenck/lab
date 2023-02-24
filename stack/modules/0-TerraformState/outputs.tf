output "Directions" {
  value = <<-EOT
    Below you'll find a "terraform" block, this block is used to configure state.tf
    files for each tier.

    Copy the block below and replace "FILL THIS IN" with the key for the given module
    you are deploying.

    NOTE: to migrate 0-TerraformState to shared state
    1. copy the block below and paste to `stack/0-TerraformState/state.tf`
    2. replace "FILL THIS IN" with "0-TerraformState"
    3. Run `terraform init`
    4. Reply "yes" to migrate state

    Centralizing this state is a good practice, but will make destroying 0-TerraformState
    more complex.
  EOT
}

output "state_config" {
  value = var.vendor == "GCP" ? module.gcpstate[*].state_config : module.awsstate[*].state_config
}
