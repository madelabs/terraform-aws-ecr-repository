# terraform-aws-ecr-repository

<!-- BEGIN MadeLabs Header -->
![MadeLabs is for hire!](https://d2xqy67kmqxrk1.cloudfront.net/horizontal_logo_white.png)
MadeLabs is proud to support the open source community with these blueprints for provisioning infrastructure to help software builders get started quickly and with confidence. 

We're also for hire: [https://www.madelabs.io](https://www.madelabs.io)
<!-- END MadeLabs Header -->
---

A Terraform module for managing an AWS ECR Repository.

## Requirements

- An existing AWS Account
<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.lifecycle_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.ecr_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecr_encryption_configuration"></a> [ecr\_encryption\_configuration](#input\_ecr\_encryption\_configuration) | The encryption type to use for the repository. Valid values are AES256 or KMS. Defaults to AES256. If using KMS, provide the KMS key ARN. | <pre>object({<br>    encryption_type = string<br>    kms_key         = string<br>  })</pre> | <pre>{<br>  "encryption_type": "AES256",<br>  "kms_key": null<br>}</pre> | no |
| <a name="input_ecr_force_delete"></a> [ecr\_force\_delete](#input\_ecr\_force\_delete) | If true, will delete the repository even if it contains images. Defaults to false. | `bool` | `false` | no |
| <a name="input_ecr_lifecycle_prefix_list"></a> [ecr\_lifecycle\_prefix\_list](#input\_ecr\_lifecycle\_prefix\_list) | The lifecycle rule expires images with this list of prefixes based on the ecr\_max\_images variable. Defaults to semver. | `list(string)` | <pre>[<br>  "0",<br>  "1",<br>  "2"<br>]</pre> | no |
| <a name="input_ecr_repo_name"></a> [ecr\_repo\_name](#input\_ecr\_repo\_name) | Name of the image, and subsequently the name of the repository. | `string` | n/a | yes |
| <a name="input_ecr_scan_policy"></a> [ecr\_scan\_policy](#input\_ecr\_scan\_policy) | Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false). | `bool` | `true` | no |
| <a name="input_ecr_tag_mutability"></a> [ecr\_tag\_mutability](#input\_ecr\_tag\_mutability) | The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE | `string` | `"MUTABLE"` | no |
| <a name="input_ecr_tagged_max_images"></a> [ecr\_tagged\_max\_images](#input\_ecr\_tagged\_max\_images) | The maximum number of images to keep in the ECR repository. | `number` | `50` | no |
| <a name="input_ecr_untagged_images_expiration_days"></a> [ecr\_untagged\_images\_expiration\_days](#input\_ecr\_untagged\_images\_expiration\_days) | The number of days to keep untagged images in the repository before expiring them. | `number` | `14` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_registry_id"></a> [registry\_id](#output\_registry\_id) | n/a |
| <a name="output_repository_arn"></a> [repository\_arn](#output\_repository\_arn) | n/a |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | n/a |
<!-- END_TF_DOCS -->