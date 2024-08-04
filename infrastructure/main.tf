module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
}

module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = [module.vpc.private_1_subnet_id,module.vpc.private_2_subnet_id]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_type = var.instance_type
  }

  eks_managed_node_groups = {
    node_group = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_type = var.instance_type

      min_size     = var.min_capacity
      max_size     = var.max_capacity
      desired_size = var.desired_capacity
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true


  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

module "ecr" {
  source = "./modules/ecr"

  repository_name = var.ecr_repository_name
}