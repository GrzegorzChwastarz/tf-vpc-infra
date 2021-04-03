resource "aws_security_group" "this" {
  name        = "${var.tags["Project"]}-${var.tags["Environment"]}-aurora"
  vpc_id      = var.vpc_module.vpc_id
  description = "Allow access from EC2 migration tier "

  tags = var.tags
}

resource "aws_security_group_rule" "ec2_rds_ingress" {
  description              = "Allow inbound connection from EC2 instance to RDS"
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = var.ec2_module.ec2_sg_id
}
