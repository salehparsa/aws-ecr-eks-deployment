variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role to associate with the EKS cluster."
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "fargate_profile_name" {
  description = "The name of the Fargate profile."
  type        = string
}

variable "fargate_role_arn" {
  description = "The ARN of the IAM role for Fargate pod execution."
  type        = string
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
      namespace = "hello-world-namespace"
      labels    = {}
    }
  ]
}