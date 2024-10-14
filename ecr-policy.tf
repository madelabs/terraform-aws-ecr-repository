
resource "aws_ecr_repository_policy" "ecr_policy" {
  count       = var.ecr_cross_account_access ? 1 : 0
  repository =  var.ecr_repo_name

  depends_on = [
    aws_ecr_repository.ecr_repo
  ]


  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
        Condition = {
          StringLike = {
            "aws:SourceArn" = "arn:aws:lambda:${var.ecr_cross_account_region}:${var.ecr_cross_account_number}:function:*"
          }
        }
      },
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.ecr_cross_account_number}:root"

        }
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
      }
    ]
  })
}


