data "aws_eks_cluster" "stack-eks" {
  name = "${var.cluster_name}"
}

data "aws_eks_cluster_auth" "stack-eks" {
  name = "${var.cluster_name}"
}

output "cluster-name" {
  value = "${var.cluster_name}"
}

output "endpoint" {
  value = data.aws_eks_cluster.stack-eks.endpoint
}

output "ca-data" {
  value = data.aws_eks_cluster.stack-eks.certificate_authority[0].data
}

output "token" {
  value = "data.aws_eks_cluster_auth.${var.project_name}.token"
}
