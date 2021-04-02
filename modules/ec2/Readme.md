<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| artifacts\_bucket\_name | n/a | `any` | n/a | yes |
| db\_endpoint\_url | n/a | `any` | n/a | yes |
| db\_instance\_id | n/a | `any` | n/a | yes |
| db\_name | n/a | `any` | n/a | yes |
| db\_password | n/a | `any` | n/a | yes |
| db\_sg\_id | n/a | `any` | n/a | yes |
| db\_username | n/a | `any` | n/a | yes |
| ec2\_name | n/a | `string` | `"migration-tier"` | no |
| ec2\_volume\_size | n/a | `string` | `"30"` | no |
| instance\_type | n/a | `string` | `"t3.medium"` | no |
| legacy\_bucket\_name | n/a | `any` | n/a | yes |
| number\_of\_db\_records | n/a | `any` | n/a | yes |
| number\_of\_files | n/a | `any` | n/a | yes |
| private\_subnet\_id | n/a | `any` | n/a | yes |
| rds\_endpoint\_sg\_id | n/a | `any` | n/a | yes |
| ssm\_sg\_id | n/a | `any` | n/a | yes |
| tags | n/a | `any` | n/a | yes |
| vpc\_id | n/a | `any` | n/a | yes |
| vpce\_s3 | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ec2\_sg\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->