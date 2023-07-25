module "ecr_repository" {
  source                              = "madelabs/ecr-repository/aws"
  version                             = "x.x.x"
  ecr_repo_name                       = "example-ecr-repo"
  ecr_scan_policy                     = true
  ecr_force_delete                    = true
  ecr_tag_mutability                  = "IMMUTABLE"
  ecr_lifecycle_prefix_list           = ["0", "1", "2", "3"]
  ecr_tagged_max_images               = 10
  ecr_untagged_images_expiration_days = 30

  ecr_encryption_configuration = {
    encryption_type = "AES256"
    kms_key         = null
  }
}
