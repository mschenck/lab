locals {
  all_azs = data.aws_availability_zones.all.names
  max_azs = length(local.all_azs)
  num_azs = min(local.max_azs, var.number_azs)
  azs     = slice(local.all_azs, 0, local.num_azs)
}

data "aws_availability_zones" "all" {
  filter {
    name   = "region-name"
    values = [var.aws_region]
  }
}

resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy

  enable_dns_hostnames             = var.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.main.id
  count             = local.num_azs
  availability_zone = data.aws_availability_zones.all.names[count.index]

  cidr_block                      = cidrsubnet(var.cidr_block, local.num_azs, count.index)
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, count.index) # Setting 8 bits to ensure a /64
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = var.map_public_ips

  depends_on = [
    aws_vpc.main,
  ]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.name
  }
}

resource "aws_default_route_table" "inet-route" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  depends_on = [
    aws_internet_gateway.gw,
  ]
}

output "availability_zones" {
  value = join(", ", tolist(local.azs))
}

output "subnets" {
  value = tolist(aws_subnet.subnet[*])
}

output "vpc_id" {
  value = aws_vpc.main.id
}
