variable "instance_class" {
  default = "db.t2.small"
}

variable "rds_master_username" {
  description = "The ID's of the VPC subnets that the RDS cluster instances will be created in"
}

variable "rds_master_password" {
  description = "The ID's of the VPC subnets that the RDS cluster instances will be created in"
}

variable "vpc_module" {}

variable "ec2_module" {}

variable "tags" {}