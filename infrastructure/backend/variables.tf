variable "region" {
  description = "The AWS region."
  type        = string
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
  default     = "hello-eks-terraform-states"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table."
  type        = string
  default     = "hello-eks-terraform-state-lock"
}