Proxmox K3s
===========


Requirements
------------

- A Proxmox deployment
- A K3s image template (see [packer/proxmox/ubuntu-k3s](../../../../packer/proxmox/ubuntu-k3s/))
- Providers: 
    - `telmate/proxmox` (`telmate/proxmox`)


Usage
-----

Intended to be deployed via a layer such as Orchestration or a Runtime layer.

Example:
```
module "Orchestration" {
  source = "../modules/proxmox/k3s"

  vm_template  = var.proxmox_vm_template
  target_node  = var.proxmox_target_node
  cluster_name = local.cluster_name
  cpu_cores    = 2
  memory_mb    = 4096
}
```

Reference
---------
- [Proxmox](https://proxmox.com/en/)
- [Proxmox Docs](https://pve.proxmox.com/pve-docs/)
- [Terraform: telmate/proxmox](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)