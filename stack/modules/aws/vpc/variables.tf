
variable "name" {
  description = "The name of the vpc"
  type        = string
}

variable "cidr_block" {
  description = "The name of the vpc"
  default     = "10.0.0.0/16"
  type        = string
}

variable "instance_tenancy" {
  default = "default"
  type    = string
}

variable "enable_dns_hostnames" {
  default = true
  type    = bool
}

variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "number_azs" {
  description = "The number of AZs for this VPC. (up to the max for given AWS region)"
  default     = 3
  type        = number
}

variable "map_public_ips" {
  default = true
  type    = bool
}
