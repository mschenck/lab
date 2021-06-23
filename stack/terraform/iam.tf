
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

resource "aws_iam_group" "k8sers" {
  name = "k8sers"
  path = "/k8sers/"
}
 
resource "aws_iam_policy_attachment" "api-access" {
  name       = "k8s api access attachment"
  groups     = [aws_iam_group.k8sers.name]
  policy_arn = aws_iam_policy.k8s-api.arn
}
