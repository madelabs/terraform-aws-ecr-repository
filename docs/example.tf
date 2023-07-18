module "ecr_repository" {
  source                    = "madelabs/ecs-cluster/aws"
  version                   = "x.x.x"
  ecr_repo_name             = "example-ecr-repo"
  ecr_scan_policy           = true
  ecr_force_delete          = true
  ecr_tag_mutability        = "IMMUTABLE"
  ecr_max_images            = 10
  ecr_lifecycle_prefix_list = ["v", "v2", "V"]

  ecr_encryption_configuration = {
    encryption_type = "AES256"
    kms_key         = null
  }
}
