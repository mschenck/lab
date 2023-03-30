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

variable "ipv4_addr" {
  type    = string
  default = ""
}

variable "ipv4_nm_bits" {
  description = "IPv4 netmask bits i.e. '24' for /24"
  type        = number
  default     = 24
}

variable "ipv4_gw" {
  type    = string
  default = ""
}

variable "nameserver" {
  type    = string
  default = "8.8.8.8"
}
