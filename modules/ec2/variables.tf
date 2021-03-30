variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_volume_size" {
  default = "30"
}

variable "vpc_id" {

}

variable "private_subnet_id" {

}

variable "vpce_s3" {

}

variable "ssm_sg_id" {

}

/*variable "rds_sg_id" {

}
*/
variable "ec2_name" {
  default = "migration-tier"
}

variable "tags" {

}