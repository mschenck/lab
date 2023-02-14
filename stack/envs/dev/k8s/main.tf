locals {
  vpc_name     = "dev"
  cluster_name = "alpine1"
  cpu_cores    = 4
  memory_mb    = 8192
  proxmox_node = "lab"
}

module "k8s" {
  source = "../../../modules/proxmox/k8s"

  cluster_name = local.cluster_name
  cpu_cores    = local.cpu_cores
  memory_mb    = local.memory_mb
  proxmox_node = local.proxmox_node
}
