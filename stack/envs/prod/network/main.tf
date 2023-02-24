locals {
  project_id   = "stack-348418"
  network_name = "prod"
  region       = "us-central1"
  zones        = ["us-central1-a"]

  # IP Allocation
  vpc_subnet_cidr = "10.0.0.0/17"
  vpc_secondary_ip_range = [
    {
      range_name    = "k8s-pods-subnet",
      ip_cidr_range = "172.16.0.0/18"
    },
    {
      range_name    = "k8s-svcs-subnet",
      ip_cidr_range = "192.168.0.0/18"
    }
  ]
}

module "gke-network" {
  source = "../../../modules/gcp/k8s-network"
  name   = local.network_name

  project_id = local.project_id
  region     = local.region

  # IP Allocation
  vpc_subnet_cidr        = local.vpc_subnet_cidr
  vpc_secondary_ip_range = local.vpc_secondary_ip_range

  #zones        = local.zones 
}
