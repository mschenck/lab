resource "google_compute_network" "network" {
  name                    = "${var.name}-k8s-network"
  project                 = var.project_id
  routing_mode            = var.routing_mode
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name    = "${var.name}-k8s-subnetwork"
  project = var.project_id
  network = google_compute_network.network.name

  region             = var.region
  ip_cidr_range      = var.vpc_subnet_cidr
  secondary_ip_range = var.vpc_secondary_ip_range

  private_ip_google_access = true
}
