terraform {
  required_version = ">= 0.14.9"
  required_providers {
    aws = {
      version = ">= 3.0.0"
      source  = "hashicorp/aws"
    }
    external = {
      version = "2.0.0"
      source  = "hashicorp/external"
    }
  }
  backend "s3" {}
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = var.region
}