
resource "aws_eks_cluster" "stack" {
  name     = var.cluster_name
  role_arn = aws_iam_role.stack-k8s-cluster.arn

  vpc_config {
    subnet_ids              = data.aws_subnets.stack.ids
    endpoint_private_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.stack-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.stack-AmazonEKSVPCResourceController,
  ]
}

resource "aws_eks_node_group" "stack" {
  cluster_name    = aws_eks_cluster.stack.name
  node_group_name = "${var.project_name}-nodes"
  node_role_arn   = aws_iam_role.stack-k8s-worker.arn
  subnet_ids      = data.aws_subnets.stack.ids
  instance_types  = [var.instance_types]

  scaling_config {
    desired_size = var.instance_desired
    max_size     = var.instance_max
    min_size     = var.instance_min
  }

  remote_access {
    ec2_ssh_key = var.key_name
  }

  depends_on = [
    aws_iam_role_policy_attachment.stack-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.stack-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.stack-AmazonEC2ContainerRegistryReadOnly,
  ]
}