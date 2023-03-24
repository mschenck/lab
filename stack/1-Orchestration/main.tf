# Tier 1 - Orchestration
locals {
  cluster_name   = "${var.orchestration_name}-orchestration-cluster"
  network_name   = "${var.orchestration_name}-orchestration-network"
  node_pool_name = "${var.orchestration_name}-orchestration-compute"

  # GCP-specific variables
  gcp_subnetwork_name  = "${var.orchestration_name}-orchestration-subnetwork"
  gcp_pods_subnet_name = "${var.orchestration_name}-orchestration-pods-subnetwork"
  gcp_svcs_subnet_name = "${var.orchestration_name}-orchestration-svcs-subnetwork"
}

### EKS Example
# module "Orchestration" {
#   source = "../modules/aws/eks"

#   cluster_name = local.cluster_name
#   region       = var.aws_region

#   # Compute
#   node_pool_name   = local.node_pool_name
#   instance_type    = var.ec2_instance_type
#   key_name         = var.ec2_key_name
#   instance_min     = var.ec2_instance_max
#   instance_max     = var.ec2_instance_max
#   instance_desired = var.ec2_instance_desired

#   # Network 
#   network_name     = local.network_name
#   cidr_block       = var.nodes_subnet_cidr
#   svcs_subnet_cidr = var.svcs_subnet_cidr
# }

### GKE Example
# module "Orchestration" {
#   source = "../modules/gcp/gke"

#   cluster_name = local.cluster_name
#   project_id   = var.gcp_project
#   region       = var.gcp_region
#   location     = var.gke_location

#   # Compute
#   node_pool_name = local.node_pool_name

#   # Network 
#   network_name     = local.network_name
#   subnetwork_name  = local.gcp_subnetwork_name
#   nodes_cidr_block = var.nodes_subnet_cidr
#   pods_subnet_name = local.gcp_pods_subnet_name
#   pods_subnet_cidr = var.pods_subnet_cidr
#   svcs_subnet_name = local.gcp_svcs_subnet_name
#   svcs_subnet_cidr = var.svcs_subnet_cidr

#   ## Auth
#   service_account_name = var.gcp_service_account_name
# }

### Proxmox Example
module "Orchestration" {
  source = "../modules/proxmox/k3s"

  vm_template  = var.proxmox_vm_template
  target_node  = var.proxmox_target_node
  cluster_name = local.cluster_name
}
