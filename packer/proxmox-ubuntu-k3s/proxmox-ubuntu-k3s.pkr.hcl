packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

# Proxmox
variable "proxmox_url" {
  type    = string
  default = "https://192.168.1.253:8006/api2/json"
}

variable "insecure_skip_tls_verify" {
  type    = bool
  default = true
}

variable "proxmox_username" {
  type = string
}

variable "proxmox_password" {
  type = string
}

variable "proxmox_node" {
  type = string
}

variable "proxmox_iso_storage_pool" {
  type = string
}

variable "proxmox_vm_storage_pool" {
  type    = string
  default = "local-zfs"
}

variable "proxmox_cloud_init_storage_pool" {
  type    = string
  default = "local"
}

# Ubuntu
variable "iso_url" {
  type    = string
  default = "https://releases.ubuntu.com/20.04.5/ubuntu-20.04.5-live-server-amd64.iso"
}

variable "iso_checksum" {
  type    = string
  default = "5035be37a7e9abbdc09f0d257f3e33416c1a0fb322ba860d42d74aa75c3468d4"
}

# K3s
variable "k3s_token" {
  type = string
}

source "proxmox-iso" "ubuntu-k3s" {
  template_name        = "ubuntu-k3s"
  template_description = "Ubuntu Linux running k3s, generated on ${timestamp()}"

  # Proxmox API configuration
  node                     = "${var.proxmox_node}"
  proxmox_url              = "${var.proxmox_url}"
  username                 = "${var.proxmox_username}"
  password                 = "${var.proxmox_password}"
  insecure_skip_tls_verify = true
  iso_download_pve         = true

  # packer VM settings
  vm_id  = 10000
  cores  = 2
  memory = 2048

  disks {
    type         = "scsi"
    disk_size    = "30G"
    storage_pool = "${var.proxmox_vm_storage_pool}"
    format       = "raw"
  }

  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }

  # ISO boot
  task_timeout     = "10m"
  iso_url          = "${var.iso_url}"
  iso_checksum     = "${var.iso_checksum}"
  iso_storage_pool = "${var.proxmox_iso_storage_pool}"
  unmount_iso      = true
  boot             = "c"
  boot_wait        = "6s"

  boot_command = [
    "<esc><wait><esc><wait><f6><wait><esc><wait>",
    "<bs><bs><bs><bs>autoinstall",
    "<enter><enter>"
  ]
  // boot_command = ["<up>e<wait><down><down><end> ip=dhcp inst.cmdline inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ubuntu-k3s.ks <f10>"]

  # Ubuntu autoinstall
  additional_iso_files {
    iso_storage_pool = "${var.proxmox_iso_storage_pool}"
    cd_files         = ["./autoinstall/meta-data", "./autoinstall/user-data"]
    cd_label         = "cidata"
  }

  # packer -> VM communication
  qemu_agent             = true
  cloud_init             = true
  ssh_pty                = true
  ssh_handshake_attempts = 20
  ssh_username           = "ubuntu"
  ssh_password           = "ubuntu"
  ssh_timeout            = "20m"

  cloud_init_storage_pool = "${var.proxmox_cloud_init_storage_pool}"
}

build {
  name = "proxmox-ubuntu-k3s"

  sources = [
    "source.proxmox-iso.ubuntu-k3s"
  ]

  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
      "ls /"
    ]
  }

  // provisioner "breakpoint" {
  //   disable = false
  //   note    = "this is a breakpoint"
  // }

  provisioner "shell" {
    inline = [
      "date > packer-generated",
      "sudo apt update",
      "curl -sfL https://get.k3s.io | sudo -S sh -s - || true"
    ]
  }
}
