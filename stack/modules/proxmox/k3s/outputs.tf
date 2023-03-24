output "endpoint" {
  value = "https://${proxmox_vm_qemu.default.ssh_host}:6443"
}

output "client_certificate_data" {
  sensitive = true
  value     = yamldecode(ssh_resource.get_kubeconfig.result).users[0].user.client-certificate-data
}

output "client_key_data" {
  sensitive = true
  value     = yamldecode(ssh_resource.get_kubeconfig.result).users[0].user.client-key-data
}

output "ca_data" {
  sensitive = true
  value     = yamldecode(ssh_resource.get_kubeconfig.result).clusters[0].cluster.certificate-authority-data
}

output "auth_user" {
  value = "default"
}
