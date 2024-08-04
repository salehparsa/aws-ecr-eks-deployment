resource "aws_ecr_repository" "this" {
  name = var.repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = var.repository_name
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode(
    {
      "rules" : [
        {
          "rulePriority" : 1,
          "description" : "Expires Tagged Images",
          "selection" : {
            "tagStatus" : "tagged",
            "tagPrefixList" : ["v"],
            "countType" : "imageCountMoreThan",
            "countNumber" : 3
          },
          "action" : {
            "type" : "expire"
          }
        },
        {
          "rulePriority" : 2,
          "description" : "Expires Untagged Images",
          "selection" : {
            "tagStatus" : "untagged",
            "countType" : "sinceImagePushed",
            "countUnit" : "days",
            "countNumber" : 3
          },
          "action" : {
            "type" : "expire"
          }
        }
      ]
  })
}
