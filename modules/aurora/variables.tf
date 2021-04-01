variable "instance_class" {
  default = "db.t3.medium"
}

variable "rds_master_username" {
  description = "The ID's of the VPC subnets that the RDS cluster instances will be created in"
}

variable "db_region" {
  default = "eu-central-1"
}

variable "rds_master_password" {
  description = "The ID's of the VPC subnets that the RDS cluster instances will be created in"
}

variable "vpc_module" {}

variable "ec2_module" {}

variable "tags" {}