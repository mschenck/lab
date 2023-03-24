1-Orchestration
===============

Tier 1 provides a platform orchestration cluster for managing:
- Service builds
- Secrets
- Infrastructure automation
- Runtime clusters/environments

## Orchestration cluster setup

Copy [./settings.auto.tfvars-TEMPLATE](./settings.auto.tfvars-TEMPLATE) to `./settings.auto.tfvars` and 
configure your Orchestration cluster.

Then, configure the "Orchestration" module using one of the provided modules below:

### EKS

See [modules/aws/eks](../modules/aws/eks/)

aws-cli command for fetching `kube_config`:

    aws eks update-kubeconfig --kubeconfig ~/.kube/aws-1-orchestration --name lab-stack-orchestration-cluster


### GKE

See [modules/gcp/gke/README.md](../modules/gcp/gke/README.md)

gcloud command for fetching `kube_config`:

    gcloud container clusters get-credentials <cluster name>-orchestration-cluster

For example:

    gcloud container clusters get-credentials lab-stack-orchestration-cluster

## Proxmox

See [modules/proxmox/k3s/README.md](../modules/proxmox/k3s/README.md)

Copy from the environment terraform was run.

    cat /tmp/<cluster name>-orchestration-cluster.kubeconfig 

For example:

    cat /tmp/lab-stack-orchestration-cluster.kubeconfig 

## Adding new K8s modules

Each module, like the ones referenced above are expected to:
1. Handle network setup
2. Handle cluster setup
3. Generate a `kube_config` to be used by Terraform (helm installations)
