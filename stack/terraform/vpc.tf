resource "aws_vpc" "stack" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"
}

resource "aws_subnet" "stack-1" {
  vpc_id            = aws_vpc.stack.id
  availability_zone = "us-east-1a"
  cidr_block        = "192.168.64.0/18"

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  depends_on = [
    aws_vpc.stack,
  ]
}

resource "aws_subnet" "stack-2" {
  vpc_id            = aws_vpc.stack.id
  availability_zone = "us-east-1c"
  cidr_block        = "192.168.128.0/18"

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  depends_on = [
    aws_vpc.stack,
  ]
}

resource "aws_subnet" "stack-3" {
  vpc_id            = aws_vpc.stack.id
  availability_zone = "us-east-1e"
  cidr_block        = "192.168.192.0/18"

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

resource "aws_eip" "nat-gw-1" {
  vpc = true
}

resource "aws_nat_gateway" "stack-nat-gw-1" {
  allocation_id = aws_eip.nat-gw-1.id
  subnet_id     = aws_subnet.stack-1.id
}

resource "aws_eip" "nat-gw-2" {
  vpc = true
}

resource "aws_nat_gateway" "stack-nat-gw-2" {
  allocation_id = aws_eip.nat-gw-2.id
  subnet_id     = aws_subnet.stack-2.id
}

resource "aws_eip" "nat-gw-3" {
  vpc = true
}

resource "aws_nat_gateway" "stack-nat-gw-3" {
  allocation_id = aws_eip.nat-gw-3.id
  subnet_id     = aws_subnet.stack-3.id
}
