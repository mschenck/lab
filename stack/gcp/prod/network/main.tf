locals {
    project_id   = "stack-348418"
    network_name = "prod"
    region       = "us-central1"
    zones        = ["us-central1-a"]

    vpc_subnet         = "10.10.0.0/17"
    k8s_pods_subnet_cidr = "172.16.0.0/18"
    k8s_svcs_subnet_cidr = "192.168.0.0/18"
}

module "gke-network" {
    source = "../../modules/k8s-network"
    name   = local.network_name

    project_id           = local.project_id
    region               = local.region

    vpc_subnet_cidr      = local.vpc_subnet
    k8s_pods_subnet_cidr = local.k8s_pods_subnet_cidr
    k8s_svcs_subnet_cidr = local.k8s_svcs_subnet_cidr

    #zones        = local.zones 
}