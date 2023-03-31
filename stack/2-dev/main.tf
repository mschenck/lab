# Tier 2 - dev
locals {
  cluster_name   = "${var.dev_name}-dev-cluster"
  network_name   = "${var.dev_name}-dev-network"
  node_pool_name = "${var.dev_name}-dev-compute"

  # GCP-specific variables
  gcp_subnetwork_name  = "${var.dev_name}-dev-subnetwork"
  gcp_pods_subnet_name = "${var.dev_name}-dev-pods-subnetwork"
  gcp_svcs_subnet_name = "${var.dev_name}-dev-svcs-subnetwork"
}


### Proxmox Example
module "Dev" {
  source = "../modules/proxmox/k3s"

  vm_template  = var.proxmox_vm_template
  target_node  = var.proxmox_target_node
  cluster_name = local.cluster_name
  cpu_cores    = 2
  memory_mb    = 4096
  ipv4_addr    = var.proxmox_ipv4_addr
  ipv4_nm_bits = var.proxmox_ipv4_netmask_bits
  ipv4_gw      = var.proxmox_ipv4_gw
}
