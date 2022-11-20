resource "aws_vpc" "stack" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "stack-1" {
  vpc_id                  = aws_vpc.stack.id
  availability_zone       = "us-east-1a"
  cidr_block              = "192.168.64.0/18"
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  depends_on = [
    aws_vpc.stack,
  ]
}

resource "aws_subnet" "stack-2" {
  vpc_id                  = aws_vpc.stack.id
  availability_zone       = "us-east-1c"
  cidr_block              = "192.168.128.0/18"
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  depends_on = [
    aws_vpc.stack,
  ]
}

resource "aws_subnet" "stack-3" {
  vpc_id                  = aws_vpc.stack.id
  availability_zone       = "us-east-1e"
  cidr_block              = "192.168.192.0/18"
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  depends_on = [
    aws_vpc.stack,
  ]
}

data "aws_subnet_ids" "stack" {
  vpc_id = aws_vpc.stack.id

  depends_on = [
    aws_vpc.stack,
    aws_subnet.stack-1,
    aws_subnet.stack-2,
    aws_subnet.stack-3,
  ]
}

resource "aws_internet_gateway" "inet-gw" {
  vpc_id = aws_vpc.stack.id
}

resource "aws_default_route_table" "inet-route" {
  default_route_table_id = aws_vpc.stack.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.inet-gw.id
  }

  depends_on = [
    aws_internet_gateway.inet-gw,
  ]
}

resource "aws_eip" "nat-gw-1" {
  vpc = true
}

resource "aws_nat_gateway" "stack-nat-gw-1" {
  allocation_id = aws_eip.nat-gw-1.id
  subnet_id     = aws_subnet.stack-1.id

  depends_on = [
    aws_eip.nat-gw-1,
    aws_internet_gateway.inet-gw,
  ]
}

resource "aws_eip" "nat-gw-2" {
  vpc = true
}

resource "aws_nat_gateway" "stack-nat-gw-2" {
  allocation_id = aws_eip.nat-gw-2.id
  subnet_id     = aws_subnet.stack-2.id

  depends_on = [
    aws_eip.nat-gw-2,
    aws_internet_gateway.inet-gw,
  ]
}

resource "aws_eip" "nat-gw-3" {
  vpc = true
}

resource "aws_nat_gateway" "stack-nat-gw-3" {
  allocation_id = aws_eip.nat-gw-3.id
  subnet_id     = aws_subnet.stack-3.id

  depends_on = [
    aws_eip.nat-gw-3,
    aws_internet_gateway.inet-gw,
  ]
}