resource "proxmox_vm_qemu" "stack" {
  name        = var.cluster_name
  target_node = var.proxmox_node

  cores   = var.cpu_cores
  memory  = var.memory_mb
  numa    = false
  scsihw  = "virtio-scsi-single"
  boot    = "order=scsi0;ide2;net0"
  qemu_os = "l26"

  define_connection_info = false
  full_clone             = false
  onboot                 = true
  oncreate               = false

  network {
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    macaddr   = "82:6F:D0:84:53:B7"
    model     = "virtio"
    mtu       = 0
    queues    = 0
    rate      = 0
    tag       = -1
  }

  disk {
    backup             = true
    cache              = "none"
    file               = "vm-100-disk-0"
    format             = "raw"
    iops               = 0
    iops_max           = 0
    iops_max_length    = 0
    iops_rd            = 0
    iops_rd_max        = 0
    iops_rd_max_length = 0
    iops_wr            = 0
    iops_wr_max        = 0
    iops_wr_max_length = 0
    iothread           = 1
    mbps               = 0
    mbps_rd            = 0
    mbps_rd_max        = 0
    mbps_wr            = 0
    mbps_wr_max        = 0
    replicate          = 0
    size               = "16G"
    slot               = 0
    ssd                = 0
    storage            = "local-zfs"
    type               = "scsi"
    volume             = "local-zfs:vm-100-disk-0"
  }
}
