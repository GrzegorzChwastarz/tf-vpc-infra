### Overview
This part is inspired by [this post](https://stackoverflow.com/questions/47913041/initial-setup-of-terraform-backend-using-terraform).
It's a solution for creating tfstate S3 bucket and DynamoDB locking table for main repository. 
Plain terraform can't handle it on it's own at its first run.

## Deployment

`aws-vault` is optional. Any credentials store tool that enable assume role will be fine.

```shell script
aws-vault exec [AWS-Profile] -- terraform init
aws-vault exec [AWS-Profile] -- terraform plan
aws-vault exec [AWS-Profile] -- terraform apply
aws-vault exec [AWS-Profile] -- terraform destroy 
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.9 |
| aws | >= 3.34.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.34.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | n/a | `string` | `"eu-central-1"` | no |
| s3\_dynamodb\_lock\_table\_name | Required unique name for the dynamoDB table that will be used by main part of this repo | `string` | `"lambda-vpce-tfstate"` | no |
| s3\_state\_bucket\_name | Required unique name for the bucket that will be used by main part of this repo | `string` | `"lambda-vpce-tfstate"` | no |

## Outputs

| Name | Description |
|------|-------------|
| s3\_dynamodb\_locking\_table\_name | n/a |
| s3\_tfstate\_bucket\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->