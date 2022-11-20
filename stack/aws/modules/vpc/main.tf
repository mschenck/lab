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
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.main.id
  count             = local.num_azs
  availability_zone = data.aws_availability_zones.all.names[count.index]
  cidr_block        = cidrsubnet(var.cidr_block, local.num_azs, count.index)

  map_public_ip_on_launch = var.map_public_ips

  depends_on = [
    aws_vpc.main,
  ]
}


output "availability_zones" {
  value = join(", ", tolist(local.azs))
}

output "subnets" {
  value = join(", ", tolist(aws_subnet.subnet[*].availability_zone))
}
