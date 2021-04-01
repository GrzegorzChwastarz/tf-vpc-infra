variable "region" {
  default = "eu-central-1"
}

variable "s3_buckets" {
  default = {
    s3_legacy = {
      s3_bucket_name = "vpce-lambda-s3-legacy"
    },
    s3_destination = {
      s3_bucket_name = "vpce-lambda-destination"
    },
    s3_artifacts = {
      s3_bucket_name = "vpce-lambda-artifacts"
    }
  }
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

