variable "region" {
  description = "The region in which the infrastructure will be deployed"
  type        = string
  default     = "eu-central-1"
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "hello-eks"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository."
  default     = "hello-ecr-repository"
}

variable "fargate_profile_name" {
  description = "The name of the Fargate profile."
  type        = string
  default     = "hello-fargate-profile"
}
variable "fargate_profiles" {
  description = "Fargate profiles configurations."
  type = list(object({
    name      = string
    namespace = string
    labels    = map(string)
  }))
  default = [
    {
      name      = "hello-fargate-profile"
      namespace = "hello-app"
      labels    = {
        "name": "hello-app"
      }
    }
  ]
}
