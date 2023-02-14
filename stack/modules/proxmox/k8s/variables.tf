variable "cluster_name" {
  type = string
}

variable "proxmox_node" {
  type = string
}

variable "cpu_cores" {
  type    = number
  default = 1
}

variable "memory_mb" {
  type    = number
  default = 2048
}
