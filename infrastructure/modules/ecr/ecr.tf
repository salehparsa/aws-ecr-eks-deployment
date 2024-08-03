resource "aws_ecrpublic_repository" "this" {
  repository_name = var.repository_name

  tags = {
    Name = var.repository_name
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecrpublic_repository.this.repository_name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Delete untagged images older than 2 days"
        selection = {
          tagStatus = "UNTAGGED"
        }
        action = {
          type = "expire"
        }
        filter = {
          countType = "sinceImagePushed"
          countUnit = "days"
          count     = 2
        }
      },
      {
        rulePriority = 2
        description  = "Delete tagged images older than 7 days"
        selection = {
          tagStatus = "TAGGED"
        }
        action = {
          type = "expire"
        }
        filter = {
          countType = "sinceImagePushed"
          countUnit = "days"
          count     = 7
        }
      }
    ]
  })
}
