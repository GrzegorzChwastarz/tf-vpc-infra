variable "region" {
  default = "eu-central-1"
}

variable "s3_state_bucket_name" {
  description = "Required unique name for the bucket that will be used by main part of this repo"
  default     = "lambda-vpce-tfstate"
}

variable "s3_dynamodb_lock_table_name" {
  description = "Required unique name for the dynamoDB table that will be used by main part of this repo"
  default     = "lambda-vpce-tfstate"
}