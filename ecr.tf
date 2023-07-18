resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.ecr_repo_name
  force_delete         = var.ecr_force_delete
  image_tag_mutability = var.ecr_tag_mutability

  dynamic "encryption_configuration" {
    for_each = var.ecr_encryption_configuration == null ? [] : [var.ecr_encryption_configuration]
    content {
      encryption_type = encryption_configuration.value.encryption_type
      kms_key         = encryption_configuration.value.kms_key
    }
  }

  image_scanning_configuration {
    scan_on_push = var.ecr_scan_policy
  }
}

locals {
  image_lifecycle_rule = [
    {
      rulePriority = 1
      description  = "Keep last ${var.ecr_tagged_max_images} tagged images"
      selection = {
        tagStatus     = "tagged"
        tagPrefixList = var.ecr_lifecycle_prefix_list
        countType     = "imageCountMoreThan"
        countNumber   = var.ecr_tagged_max_images
      }
      action = {
        type = "expire"
      }
    },
    {
      rulePriority = 2
      description  = "Expire untagged images older than ${var.ecr_untagged_images_expiration_days} days"
      selection = {
        tagStatus   = "untagged"
        countType   = "sinceImagePushed"
        countUnit   = "days"
        countNumber = var.ecr_untagged_images_expiration_days
      }
      action = {
        type = "expire"
      }
    }
  ]
}

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  repository = aws_ecr_repository.ecr_repo.name

  policy = jsonencode({
    rules = local.image_lifecycle_rule
  })
}
