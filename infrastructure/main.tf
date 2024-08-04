module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
}

module "iam" {
  source = "./modules/iam"

  cluster_name = var.cluster_name
}

module "eks_cluster" {
  source = "./modules/eks-cluster"

  cluster_name         = var.cluster_name
  subnet_ids           = [module.vpc.private_1_subnet_id,module.vpc.private_2_subnet_id]
  role_arn             = module.iam.eks_cluster_role_arn
  fargate_role_arn     = module.iam.eks_fargate_role_arn
  fargate_profiles     = var.fargate_profiles
  fargate_profile_name = var.fargate_profile_name
}

module "ecr" {
  source = "./modules/ecr"

  repository_name = var.ecr_repository_name
}