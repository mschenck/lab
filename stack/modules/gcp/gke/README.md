GKE - Google Kubernetes Engine
==============================

Requirements
------------

- Providers: 
    - `google` (`hashicorp/google`)


Usage
-----

Intended to be deployed via a layer such as Orchestration or a Runtime layer.

Example:
```
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
```


Reference
---------
- [Creating a zonal cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-zonal-cluster)
- [Terraform Kubernetes Engine Module](https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest?tab=inputs) A Terraform module for configuring GKE clusters.
- Example: [private zonal w/ networking](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/blob/v21.0.0/examples/private_zonal_with_networking/main.tf)
