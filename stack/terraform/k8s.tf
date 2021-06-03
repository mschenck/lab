# k8s controller setup
resource "aws_iam_role" "stack-k8s-cluster" {
  name = "eks-cluster-${var.project_name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "stack-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.stack-k8s-cluster.name
}

resource "aws_iam_role_policy_attachment" "stack-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.stack-k8s-cluster.name
}

resource "aws_eks_cluster" "stack-eks" {
  name     = "${var.cluster_name}"
  role_arn = aws_iam_role.stack-k8s-cluster.arn

  vpc_config {
    subnet_ids              = data.aws_subnet_ids.stack.ids
    endpoint_private_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.stack-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.stack-AmazonEKSVPCResourceController,
  ]
}


# k8s node group setup
resource "aws_iam_role" "stack-k8s-worker" {
  name = "eks-worker-${var.project_name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
resource "aws_iam_role_policy_attachment" "stack-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.stack-k8s-worker.name
}

resource "aws_iam_role_policy_attachment" "stack-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.stack-k8s-worker.name
}

resource "aws_iam_role_policy_attachment" "stack-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.stack-k8s-worker.name
}

resource "aws_eks_node_group" "stack-eks" {
  cluster_name    = aws_eks_cluster.stack-eks.name
  node_group_name = "${var.project_name}-nodes"
  node_role_arn   = aws_iam_role.stack-k8s-worker.arn
  subnet_ids      = data.aws_subnet_ids.stack.ids

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = "mschenck-ec2"
  }

  depends_on = [
    aws_iam_role_policy_attachment.stack-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.stack-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.stack-AmazonEC2ContainerRegistryReadOnly,
  ]
}


# outputs
output "endpoint" {
  value = "aws_eks_cluster.stack-eks.endpoint"
}

output "kubeconfig-certificate-authority-data" {
  value = "aws_eks_cluster.${var.project_name}.certificate_authority[0].data"
}
