resource "local_sensitive_file" "kubeconfig" {
  filename = "/tmp/${var.cluster_name}.kubeconfig"

  content = templatefile("${path.module}/kubeconfig.tftpl", {
    ca_certificate          = var.ca_certificate,
    endpoint                = var.endpoint,
    cluster_name            = var.cluster_name,
    user                    = var.user,
    client_token            = var.client_token,
    client_certificate_data = var.client_certificate_data,
    client_key_data         = var.client_key_data
  })
}
