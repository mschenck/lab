output "gateway_ipv4" {
  value = google_compute_network.network.gateway_ipv4
}

output "id" {
  value = google_compute_network.network.id
}

output "network_name" {
  value = google_compute_network.network.name
}

output "subnetwork_name" {
  value = google_compute_subnetwork.subnetwork.name
}

output "k8s_svcs_subnet_name" {
  value = var.k8s_svcs_subnet_name
}
output "k8s_pods_subnet_name" {
  value = var.k8s_pods_subnet_name
}