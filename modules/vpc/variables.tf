variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "sensitive_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "ec2_sg_id" {}

variable "tags" {}