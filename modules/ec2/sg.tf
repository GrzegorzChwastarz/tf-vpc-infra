resource "aws_security_group" "ec2_migration_tier" {
  vpc_id = var.vpc_id
  description = "Provides access to S3/Aurora/SSM parameter store"
}

/*resource "aws_security_group_rule" "ec2_rds_egress" {
  description = "Allow outbound connection from EC2 instance to RDS"
  type = "egress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  security_group_id = aws_security_group.ec2_migration_tier.id
  source_security_group_id = var.rds_sg_id
}
*/

data "aws_prefix_list" "s3" {
  prefix_list_id = var.vpce_s3.prefix_list_id
}

resource "aws_security_group_rule" "ec2_s3_endpoint_egress" {
  description       = "Allow outbound connection from EC2 instance to S3 VPC Endpoint"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_migration_tier.id
  cidr_blocks       = data.aws_prefix_list.s3.cidr_blocks
}

