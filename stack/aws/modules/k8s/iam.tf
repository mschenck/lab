
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

resource "aws_iam_role_policy_attachment" "stack-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.stack-k8s-cluster.name
}

resource "aws_iam_role_policy_attachment" "stack-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.stack-k8s-cluster.name
}


resource "aws_iam_policy" "k8s-api" {
  name        = "k8s-api-access"
  path        = "/"
  description = "Allow access to k8s API"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["eks:AccessKubernetesApi"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group" "k8users" {
  name = "k8users"
  path = "/k8users/"
}

resource "aws_iam_policy_attachment" "api-access" {
  name       = "k8s api access attachment"
  groups     = [aws_iam_group.k8users.name]
  policy_arn = aws_iam_policy.k8s-api.arn
}
