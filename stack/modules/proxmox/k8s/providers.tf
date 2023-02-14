terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
    }
  }
}

provider "proxmox" {
  pm_debug = true
}
