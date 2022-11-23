variable "project_name" {
  default = "stack"
}

variable "vpc_name" {
  description = "The name of the vpc"
  type        = string
}

variable "cluster_name" {
  default = "stack-cluster"
}

variable "instance_types" {
  type    = string
  default = "t3.micro"
}

variable "instance_min" {
  type    = number
  default = 1
}

variable "instance_max" {
  type    = number
  default = 1
}

variable "instance_desired" {
  type    = number
  default = 1
}

variable "key_name" {
  description = "AWS keypair name"
  type        = string
}
