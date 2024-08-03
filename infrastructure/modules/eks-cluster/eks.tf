resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

}

resource "aws_eks_fargate_profile" "this" {
  for_each = { for profile in var.fargate_profiles : profile.name => profile }

  cluster_name           = aws_eks_cluster.this.name
  fargate_profile_name   = each.value.name
  pod_execution_role_arn = var.fargate_role_arn

  selector {
    namespace = each.value.namespace
    labels    = each.value.labels
  }

  subnet_ids = var.subnet_ids
}