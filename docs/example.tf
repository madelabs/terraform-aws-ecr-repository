module "ecr_repository" {
  source                              = "madelabs/ecr-repository/aws"
  version                             = "0.0.2"
  ecr_repo_name                       = "example-ecr-repo"
  ecr_scan_policy                     = true
  ecr_force_delete                    = true
  ecr_tag_mutability                  = "MUTABLE"
  ecr_lifecycle_prefix_list           = ["0", "1", "2", "3"]
  ecr_tagged_max_images               = 10
  ecr_untagged_images_expiration_days = 30
  ecr_enable_enhanced_scanning        = true
  ecr_enable_enhanced_scanning_alerts = true

  ecr_scanning_events_sns_topic_subscription_endpoint = "https://events.pagerduty.com/integration/12345678901234567890/enqueue"

  ecr_encryption_configuration = {
    encryption_type = "AES256"
    kms_key         = null
  }
}
