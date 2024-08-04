output "ecr_repository_arn" {
  value       = aws_ecr_repository.this.arn
  description = "Full ARN of the repository"
}

output "ecr_repository_all_tags" {
  value       = aws_ecr_repository.this.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}