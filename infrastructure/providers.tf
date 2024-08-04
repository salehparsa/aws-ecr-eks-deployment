terraform {

  backend "s3" {
    bucket         = "hello-eks-terraform-state"
    key            = "/"
    region         = var.region
    encrypt        = true
    dynamodb_table = "hello-eks-terraform-state-lock"
  }  

  required_version = "= 1.9.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.61.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      managed_by  = "terraform"
      Environment = "dev"
    }
  }
}

provider "kubernetes" {
  host                   = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.main.token
}