terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.9"
    }
    ssh = {
      source  = "loafoe/ssh"
      version = "2.6.0"
    }
  }
}
