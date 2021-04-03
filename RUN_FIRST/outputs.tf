output "s3_tfstate_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "s3_dynamodb_locking_table_name" {
  value = aws_dynamodb_table.terraform_state_lock.name
}