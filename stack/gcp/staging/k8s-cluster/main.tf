locals {
  project_id         = "stack-348418"
  name               = "staging-gke-cluster"
  region             = "us-central1"
  zones              = ["us-central1-a"]
  location           = "us-central1-a" # Zonal cluster
  service_account_id = "staging-gke-service-account"

  # Compute
  node_pool_name = "staging-gke-default-nodes"
  min_node_count = 2
  max_node_count = 6

  # Network
  network_name     = "staging-k8s-network"
  subnetwork_name  = "staging-k8s-subnetwork"
  pods_subnet_name = "k8s-pods-subnet"
  svcs_subnet_name = "k8s-svcs-subnet"
}

# use remote state for variables

module "k8s-cluster" {
  source = "../../modules/gke"

  cluster_name       = local.name
  project_id         = local.project_id
  location           = local.location
  service_account_id = local.service_account_id

  # Compute
  node_pool_name = local.node_pool_name
  min_node_count = local.min_node_count
  max_node_count = local.max_node_count

  # Network
  network_name     = local.network_name
  subnetwork_name  = local.subnetwork_name
  pods_subnet_name = local.pods_subnet_name
  svcs_subnet_name = local.svcs_subnet_name
}

# Now enables:
#
#    provider "kubernetes" {
#      host                   = "https://${module.k8s-cluster.endpoint}"
#      token                  = data.google_client_config.default.access_token
#      cluster_ca_certificate = base64decode(module.k8s-cluster.master_auth.0.ca_certificate)
#    }
