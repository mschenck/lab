# This module will create the resources necessary for running the Orchestration layer.
# 
# Only one vendor will be implemented, this selection is performed via the "vendor" variable.

# AWS

## Network

module "aws-orchestration-network" {
  source = "../aws/vpc"

  name   = var.network_name
  region = var.aws_region

  # IP Allocation
  cidr_block = var.nodes_cidr_block

  count = var.vendor == "AWS" ? 1 : 0
}

## Cluster
module "aws-orchestration-cluster" {
  source = "../aws/k8s"

  cluster_name = var.cluster_name
  vpc_name     = var.network_name

  instance_types = var.ec2_instance_type
  key_name       = var.ec2_key_name

  # Network
  svcs_subnet_cidr = var.svcs_subnet_cidr

  # Compute
  node_pool_name = var.gcp_node_pool_name

  depends_on = [
    module.aws-orchestration-network
  ]

  count = var.vendor == "AWS" ? 1 : 0
}

# GCP

## Network
module "gcp-orchestration-network" {
  source = "../gcp/vpc"

  name            = var.network_name
  subnetwork_name = var.gcp_subnetwork_name
  project_id      = var.gcp_project
  region          = var.gcp_region

  # IP Allocation
  vpc_subnet_cidr = var.nodes_cidr_block
  vpc_secondary_ip_range = [
    {
      range_name    = var.gcp_pods_subnet_name,
      ip_cidr_range = var.pods_subnet_cidr
    },
    {
      range_name    = var.gcp_svcs_subnet_name,
      ip_cidr_range = var.svcs_subnet_cidr
    }
  ]

  count = var.vendor == "GCP" ? 1 : 0
}

## Cluster
module "gcp-orchestration-cluster" {
  source = "../gcp/gke"

  cluster_name = var.cluster_name
  network_name = var.network_name
  project_id   = var.gcp_project
  location     = var.gke_location

  # Auth
  service_account_name = var.gcp_service_account_name

  # Network
  subnetwork_name  = var.gcp_subnetwork_name
  pods_subnet_name = var.gcp_pods_subnet_name
  svcs_subnet_name = var.gcp_svcs_subnet_name

  # Compute
  node_pool_name = var.gcp_node_pool_name
  machine_type   = var.gcp_machine_type

  depends_on = [
    module.gcp-orchestration-network
  ]

  count = var.vendor == "GCP" ? 1 : 0
}
