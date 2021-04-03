variable "region" {
  default = "eu-central-1"
}

variable "s3_buckets" {
  default = {
    s3_legacy = {
      s3_bucket_name = "legacy-bucket-for-challenge"
    },
    s3_destination = {
      s3_bucket_name = "ec2-destination-bucket-challenge"
    },
    s3_artifacts = {
      s3_bucket_name = "artifacts-bucket-challenge"
    },
    s3_lambda_target = {
      s3_bucket_name = "lambda-event-target-bucket-challenge"
    }
  }
}

variable "old_s3_prefix" {
  description = "Lambda specific var. Thanks to it lambda knows which prefix remove from the file."
  default     = "image"
}

variable "new_s3_prefix" {
  description = "Lambda specific var. Thanks to it lambda knows which prefix apply to object in destination bucket."
  default     = "avatar"
}

variable "number_of_files" {
  description = "How many files will be created by instance during it's start (and then synced with bucket legacy-bucket-for-challenge)"
  default     = "100"
}

variable "number_of_db_records" {
  description = "How many records will be created by instance during it's start"
  default     = "100"
}

variable "db_username" {
  default = "abuser"
}

variable "db_password" {
  default = "test998899"
}

variable "tags" {
  default = {
    Environment = "dev"
    Project     = "lambda-vpce"
    Owner       = "gchwastarz"
  }
}

