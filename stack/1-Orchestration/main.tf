# Tier 1 - Orchestration
locals {
  cluster_name = "${var.orchestration_name}-orchestration-cluster"
  network_name = "${var.orchestration_name}-orchestration-network"

  # GCP-specific variables
  gcp_subnetwork_name  = "${var.orchestration_name}-orchestration-subnetwork"
  gcp_pods_subnet_name = "${var.orchestration_name}-orchestration-pods-subnetwork"
  gcp_svcs_subnet_name = "${var.orchestration_name}-orchestration-svcs-subnetwork"
  gcp_node_pool_name   = "${var.orchestration_name}-orchestration-compute"
}

### Proxmox Example
# module "Orchestration" {
#   source = "../modules/proxmox/k3s"

#   vm_template  = var.proxmox_vm_template
#   target_node  = var.proxmox_target_node
#   cluster_name = local.cluster_name
# }

### GKE Example
module "Orchestration" {
  source = "../modules/gcp/gke"

  cluster_name = local.cluster_name
  project_id   = var.gcp_project
  region       = var.gcp_region
  location     = var.gke_location

  # Compute
  node_pool_name = local.gcp_node_pool_name

  # Network 
  network_name     = local.network_name
  subnetwork_name  = local.gcp_subnetwork_name
  nodes_cidr_block = var.nodes_subnet_cidr
  pods_subnet_name = local.gcp_pods_subnet_name
  pods_subnet_cidr = var.pods_subnet_cidr
  svcs_subnet_name = local.gcp_svcs_subnet_name
  svcs_subnet_cidr = var.svcs_subnet_cidr

  ## Auth
  service_account_name = var.gcp_service_account_name
}

# module "Orchestration" {
#   source = "../modules/1-Orchestration"
#   vendor = var.orchestration_vendor

#   cluster_name = local.cluster_name
#   network_name = local.network_name

#   # Network variables
#   nodes_cidr_block = var.nodes_subnet_cidr
#   pods_subnet_cidr = var.pods_subnet_cidr
#   svcs_subnet_cidr = var.svcs_subnet_cidr

#   # AWS-specific variables
#   ec2_instance_type = var.ec2_instance_type
#   ec2_key_name      = var.ec2_key_name

#   # GCP-specific variables
#   gcp_project  = var.gcp_project
#   gcp_region   = var.gcp_region
#   gke_location = var.gke_location

#   ## Auth
#   gcp_service_account_name = var.gcp_service_account_name

#   ## Networking
#   gcp_subnetwork_name  = local.gcp_subnetwork_name
#   gcp_pods_subnet_name = local.gcp_pods_subnet_name
#   gcp_svcs_subnet_name = local.gcp_svcs_subnet_name
#   gcp_node_pool_name   = local.gcp_node_pool_name

#   # Proxmox-specific variables
#   proxmox_vm_template = var.proxmox_vm_template
#   proxmox_target_node = var.proxmox_target_node
# }

#module "Orchestration_kubeconfig" {
#  source = "../modules/kubeconfig"
#
#  ca_certificate = module.Orchestration.ca_data[0]
#  endpoint       = module.Orchestration.endpoint[0]
#  cluster_name   = "Orchestration"
#  user           = module.Orchestration.auth_user[0]
#  client_token   = module.Orchestration.token[0]
#
#  depends_on = [
#    module.Orchestration
#  ]
#}
