resource "proxmox_vm_qemu" "default" {
  name        = var.cluster_name
  desc        = "Cluster ${var.cluster_name}"
  target_node = var.target_node
  qemu_os     = "other"

  vmid  = var.vmid
  clone = var.vm_template
  agent = 1

  cores   = var.cpu_cores
  memory  = var.memory_mb
  os_type = "cloud-init"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  ciuser     = "ubuntu"
  cipassword = "password"

  ipconfig0 = var.ipv4_addr != "" ? "ip=${var.ipv4_addr}/${var.ipv4_nm_bits},gw=${var.ipv4_gw}" : "dhcp"

  nameserver = var.nameserver
}

resource "ssh_resource" "get_kubeconfig" {
  host     = var.ipv4_addr != "" ? var.ipv4_addr : proxmox_vm_qemu.default.ssh_host
  user     = "ubuntu"
  password = "password"

  commands = [
    "sudo cat /etc/rancher/k3s/k3s.yaml"
  ]

  depends_on = [
    proxmox_vm_qemu.default
  ]
}

module "Orchestration_kubeconfig" {
  source = "../../kubeconfig"

  ca_certificate          = yamldecode(ssh_resource.get_kubeconfig.result).clusters[0].cluster.certificate-authority-data
  endpoint                = var.ipv4_addr != "" ? "https://${var.ipv4_addr}:6443" : "https://${proxmox_vm_qemu.default.ssh_host}:6443"
  cluster_name            = var.cluster_name
  user                    = "default"
  client_certificate_data = yamldecode(ssh_resource.get_kubeconfig.result).users[0].user.client-certificate-data
  client_key_data         = yamldecode(ssh_resource.get_kubeconfig.result).users[0].user.client-key-data

  depends_on = [
    ssh_resource.get_kubeconfig
  ]
}
