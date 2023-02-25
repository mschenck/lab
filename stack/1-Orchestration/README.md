1-Orchestration
===============

Tier 1 provides a platform orchestration cluster for managing:
- Service builds
- Secrets
- Infrastructure automation
- Runtime clusters/environments

## Orchestration cluster kubeconfig

### AWS

aws-cli command for fetching `kube_config`:

    aws eks update-kubeconfig --kubeconfig ~/.kube/aws-1-orchestration --name lab-stack-orchestration-cluster

