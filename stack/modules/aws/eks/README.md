EKS
===

Requirements
------------

- Providers: 
    - `aws` (`hashicorp/aws`)


Usage
-----

Intended to be deployed via a layer such as Orchestration or a Runtime layer.

Example:
```
module "Orchestration" {
  source = "../modules/aws/eks"

  cluster_name = local.cluster_name
  region       = var.aws_region

  # Compute
  node_pool_name   = local.node_pool_name
  instance_type    = var.ec2_instance_type
  key_name         = var.ec2_key_name
  instance_min     = var.ec2_instance_max
  instance_max     = var.ec2_instance_max
  instance_desired = var.ec2_instance_desired

  # Network 
  network_name     = local.network_name
  cidr_block       = var.nodes_subnet_cidr
  svcs_subnet_cidr = var.svcs_subnet_cidr
}
```
