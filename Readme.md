## Deployment
This code has been structured in such a way as to allow deployments to any AWS account.
Moreover, since vanilla Terraform is in effect here (no [Terragrunts](https://terragrunt.gruntwork.io/), no [Makefiles](https://git.nonprod.williamhill.plc/gaming/cloud/tools/gaming-makefile)),
[any and all Terraform CLI's commands](https://www.terraform.io/docs/commands/index.html) can be used, e.g.:  

**a)** sample init
```bash
aws-vault exec [AWS-Profile] -- terraform init \
-backend=true \
-backend-config="region=eu-central-1" \
-backend-config="bucket=lambda-vpce-tfstate" \
-backend-config="key=terraform.tfstate" \
-backend-config="dynamodb_table=lambda-vpce-tfstate" \
-backend-config="encrypt=true" \
-get=true
```

**b)** plan
```
```bash
aws-vault exec [AWS-Profile] -- terraform plan
```
**c)** plan with resource targeting
```bash
aws-vault exec [AWS-Profile] -- terraform plan -target module.vpc
```
**d)** apply
```bash
aws-vault exec [AWS-Profile] -- terraform apply
```
**e)** destroy
```bash
aws-vault exec [AWS-Profile] -- terraform destroy
```
**f)** import, output, refresh, taint, console, etc.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.9 |
| aws | >= 3.0.0 |
| external | 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | n/a | `string` | `"eu-central-1"` | no |
| s3\_buckets | n/a | `map` | <pre>{<br>  "s3_artifacts": {<br>    "s3_bucket_name": "vpce-lambda-artifacts"<br>  },<br>  "s3_destination": {<br>    "s3_bucket_name": "vpce-lambda-destination"<br>  },<br>  "s3_legacy": {<br>    "s3_bucket_name": "vpce-lambda-s3-trololo"<br>  }<br>}</pre> | no |
| tags | n/a | `map` | <pre>{<br>  "Environment": "dev",<br>  "Owner": "gchwastarz",<br>  "Project": "lambda-vpce"<br>}</pre> | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->