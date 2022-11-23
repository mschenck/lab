
variable "vpc_id" {
  description = "The region of the k8s cluster"
}

variable "number_instances" {
  description = "The number of perimeter instances."
  default     = 1
  type        = number
}

variable "ami_id" {
  default = "ami-0b0dcb5067f052a63"
  type    = string
}

variable "instance_type" {
  default = "t3.micro"
  type    = string
}

variable "key_name" {
  description = "AWS keypair name"
  type        = string
}

variable "subnets" {
  description = "Subnets for perimeter nodes"
  type = list(object({
    id = string
  }))
}
