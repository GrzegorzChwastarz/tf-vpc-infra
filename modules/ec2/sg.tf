resource "aws_security_group" "ec2_migration_tier" {
  name        = "${var.tags["Project"]}-${var.tags["Environment"]}-migration-tier"
  vpc_id      = var.vpc_id
  description = "Provides access to S3/Aurora/SSM parameter store"

  tags = var.tags
}

resource "aws_security_group_rule" "ec2_rds_egress" {
  description              = "Allow outbound connection from EC2 instance to RDS"
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_migration_tier.id
  source_security_group_id = var.db_sg_id
}

data "aws_prefix_list" "s3" {
  prefix_list_id = var.vpce_s3.prefix_list_id
}

resource "aws_security_group_rule" "ec2_s3_endpoint_egress_https" {
  description       = "Allow outbound connection from EC2 instance to S3 VPC Endpoint"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_migration_tier.id
  prefix_list_ids   = [var.vpce_s3.prefix_list_id]
}

resource "aws_security_group_rule" "ec2_s3_endpoint_egress_http" {
  description       = "Allow outbound http connection from EC2 instance to S3 VPC Endpoint"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_migration_tier.id
  prefix_list_ids   = [var.vpce_s3.prefix_list_id]
}

resource "aws_security_group_rule" "ec2_ssmmessages_endpoint_egress" {
  description              = "Allow outbound connection from EC2 instance to ssm/ssmmessages/ec2messages VPC Endpoints"
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_migration_tier.id
  source_security_group_id = var.ssm_sg_id
}

resource "aws_security_group_rule" "ec2_rds_endpoint_egress" {
  description              = "Allow outbound connection from EC2 instance to RDS VPC Endpoints for API calls"
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_migration_tier.id
  source_security_group_id = var.rds_endpoint_sg_id
}


