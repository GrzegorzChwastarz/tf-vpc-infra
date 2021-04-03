variable "instance_type" {
  default = "t3.medium"
}

variable "ec2_volume_size" {
  default = "30"
}

variable "vpc_id" {}

variable "private_subnet_id" {}

variable "vpce_s3" {}

variable "ssm_sg_id" {}

variable "rds_endpoint_sg_id" {}

variable "db_sg_id" {}

variable "ec2_name" {
  default = "migration-tier"
}

variable "number_of_files" {}

variable "number_of_db_records" {}

variable "artifacts_bucket_name" {}

variable "legacy_bucket_name" {}

variable "db_instance_id" {}

variable "db_username" {}

variable "db_password" {}

variable "db_endpoint_url" {}

variable "db_name" {}

variable "tags" {}