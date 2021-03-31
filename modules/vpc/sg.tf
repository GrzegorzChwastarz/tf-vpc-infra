resource "aws_security_group" "ssm" {
  vpc_id      = aws_vpc.this.id
  name        = "common-ssm"
  description = "Security group that allows access to the VPC ssmmessages and ec2messages endpoints"

  tags = var.tags
}

resource "aws_security_group_rule" "ssm" {
  security_group_id        = aws_security_group.ssm.id
  description              = "Rule allowing connection to the VPC ssmmessages and ec2messages endpoints from ec2 migration tier"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = var.ec2_sg_id
}

resource "aws_security_group" "rds_endpoint" {
  vpc_id      = aws_vpc.this.id
  name        = "rds-endpoint"
  description = "Security group that allows access from EC2 or Lambda to Aurora"

  tags = var.tags
}

resource "aws_security_group_rule" "rds" {
  security_group_id        = aws_security_group.rds_endpoint.id
  description              = "Rule allowing connection to the RDS endpoint from EC2 and lambda"
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = var.ec2_sg_id
}