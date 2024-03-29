resource "aws_eks_cluster" "stack" {
  name     = var.cluster_name
  role_arn = aws_iam_role.stack-k8s-cluster.arn

  vpc_config {
    subnet_ids              = aws_subnet.main[*].id
    endpoint_private_access = true
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.svcs_subnet_cidr
  }


  depends_on = [
    aws_iam_role_policy_attachment.stack-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.stack-AmazonEKSVPCResourceController,
  ]
}

resource "aws_eks_node_group" "stack" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_pool_name
  node_role_arn   = aws_iam_role.stack-k8s-worker.arn
  subnet_ids      = aws_subnet.main[*].id
  instance_types  = [var.instance_type]

  scaling_config {
    desired_size = var.instance_desired
    max_size     = var.instance_max
    min_size     = var.instance_min
  }

  remote_access {
    ec2_ssh_key = var.key_name
  }

  depends_on = [
    aws_eks_cluster.stack,
    aws_iam_role_policy_attachment.stack-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.stack-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.stack-AmazonEC2ContainerRegistryReadOnly,
  ]
}

module "Orchestration_kubeconfig" {
  source = "../../kubeconfig"

  ca_certificate = aws_eks_cluster.stack.certificate_authority[0].data
  endpoint       = aws_eks_cluster.stack.endpoint
  cluster_name   = var.cluster_name
  user           = data.aws_eks_cluster_auth.stack.name
  client_token   = data.aws_eks_cluster_auth.stack.token

  depends_on = [
    aws_eks_cluster.stack
  ]
}
