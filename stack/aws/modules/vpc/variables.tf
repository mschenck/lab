
variable "name" {
  description = "The name of the vpc"
  type        = string
}

variable "cidr_block" {
  description = "The name of the vpc"
  default     = "10.0.0.0/16"
  type        = string
}
