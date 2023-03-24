variable "cluster_name" {
  type = string
}

variable "target_node" {
  type = string
}

variable "vmid" {
  type    = number
  default = 0
}

variable "vm_template" {
  description = "The name of the VM template to clone (created with Packer)"
  type        = string
}

variable "cpu_cores" {
  type    = number
  default = 1
}

variable "memory_mb" {
  type    = number
  default = 2048
}
