
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

output "cluster_name" {
  value = var.cluster_name
}

output "endpoint" {
  value = data.aws_eks_cluster.stack.endpoint
}

output "ca_data" {
  value = data.aws_eks_cluster.stack.certificate_authority[0].data
}

output "token" {
  value = "data.aws_eks_cluster_auth.${var.project_name}.token"
}

