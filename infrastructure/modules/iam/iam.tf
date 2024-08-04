# User for GitHub Actions

resource "aws_iam_user" "iam-user" {
  name = "hello-iam-user"
}

resource "aws_iam_user_policy_attachment" "ecr_policy_attachment" {
  user       = aws_iam_user.iam-user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_user_policy_attachment" "eks_policy_attachment" {
  user       = aws_iam_user.iam-user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_user_policy_attachment" "github_action_policy_attachment" {
  user       = aws_iam_user.iam-user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}