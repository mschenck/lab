
data "aws_eks_cluster" "stack" {
  name = var.cluster_name
  depends_on = [
    aws_eks_cluster.stack
  ]
}

data "aws_eks_cluster_auth" "stack" {
  name = var.cluster_name
  depends_on = [
    aws_eks_cluster.stack
  ]
}

// ---

// EKS

output "cluster_name" {
  value = var.cluster_name
}

output "endpoint" {
  value = aws_eks_cluster.stack.endpoint
}

output "ca_data" {
  value = aws_eks_cluster.stack.certificate_authority[0].data
}

output "token" {
  value = data.aws_eks_cluster_auth.stack.token
}

output "auth_user" {
  value = data.aws_eks_cluster_auth.stack.name
}

// VPC

output "availability_zones" {
  value = join(", ", tolist(local.azs))
}

output "subnets" {
  value = tolist(aws_subnet.main[*])
}

output "vpc_id" {
  value = aws_vpc.main.id
}
