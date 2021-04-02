<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ec2\_sg\_id | n/a | `any` | n/a | yes |
| private\_subnet\_cidr | n/a | `string` | `"10.0.1.0/24"` | no |
| sensitive\_dummy\_subnet\_cidr | Subnet that is only for preventing error caused by multi-az requirement from Aurora db subnet group | `string` | `"10.0.3.0/24"` | no |
| sensitive\_subnet\_cidr | n/a | `string` | `"10.0.2.0/24"` | no |
| tags | n/a | `any` | n/a | yes |
| vpc\_cidr | n/a | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| private\_subnet\_id | n/a |
| rds\_endpoint\_sg\_id | n/a |
| sensitive\_dummy\_subnet\_id | n/a |
| sensitive\_subnet\_id | n/a |
| ssm\_endpoint\_sg\_id | n/a |
| vpc\_id | n/a |
| vpce\_s3 | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->