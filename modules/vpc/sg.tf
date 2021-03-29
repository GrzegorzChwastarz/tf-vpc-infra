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