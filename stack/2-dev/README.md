2-dev
===============

Tier 2 provides a platform dev cluster for managing:
- CD

## dev cluster setup

Copy [./settings.auto.tfvars-TEMPLATE](./settings.auto.tfvars-TEMPLATE) to `./settings.auto.tfvars` and 
configure your dev cluster.

Then, configure the "dev" module using one of the provided modules below:


## Proxmox

See [modules/proxmox/k3s/README.md](../modules/proxmox/k3s/README.md)

Copy from the environment terraform was run.

    cat /tmp/<cluster name>-dev-cluster.kubeconfig 

For example:

    cat /tmp/lab-stack-dev-cluster.kubeconfig 

## Adding new K8s modules

Each module, like the ones referenced above are expected to:
1. Handle network setup
2. Handle cluster setup
3. Generate a `kube_config` to be used by Terraform (helm installations)
