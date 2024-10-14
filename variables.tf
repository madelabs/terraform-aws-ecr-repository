variable "ecr_repo_name" {
  type        = string
  description = "Name of the image, and subsequently the name of the repository."
}

variable "ecr_scan_policy" {
  type        = bool
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  default     = true
}

variable "ecr_force_delete" {
  type        = bool
  description = "If true, will delete the repository even if it contains images. Defaults to false."
  default     = false
}

variable "ecr_tag_mutability" {
  type        = string
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE"
  default     = "MUTABLE"

  validation {
    condition     = can(regex("MUTABLE|IMMUTABLE", var.ecr_tag_mutability))
    error_message = "Must be one of: MUTABLE or IMMUTABLE."
  }
}

variable "ecr_encryption_configuration" {
  type = object({
    encryption_type = string
    kms_key         = string
  })
  default = {
    encryption_type = "AES256"
    kms_key         = null
  }
  description = "The encryption type to use for the repository. Valid values are AES256 or KMS. Defaults to AES256. If using KMS, provide the KMS key ARN."
}

variable "ecr_lifecycle_prefix_list" {
  type        = list(string)
  description = "The lifecycle rule expires images with this list of prefixes based on the ecr_max_images variable. Defaults to semver."
  default     = ["0", "1", "2"]
}

variable "ecr_untagged_images_expiration_days" {
  type        = number
  description = "The number of days to keep untagged images in the repository before expiring them."
  default     = 14
}

variable "ecr_tagged_max_images" {
  type        = number
  description = "The maximum number of images to keep in the ECR repository."
  default     = 50
}

variable "ecr_cross_account_access" {
  type        = bool
  description = "Allows for letting another AWS account access your ECR policy using ECR Policy rules"
  default     = false
}

variable "ecr_cross_account_number" {
  type        = string
  description = "AWS account that will be granted access to ECR"
  default     = "222222222222"
}

variable "ecr_cross_account_region" {
  type        = string
  description = "AWS account that will be granted access to ECR's region"
  default     = "us-east-1"
}
