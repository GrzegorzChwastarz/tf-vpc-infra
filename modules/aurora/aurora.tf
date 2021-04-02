data "aws_region" "current" {}

resource "aws_rds_cluster" "this" {
  cluster_identifier     = "${var.tags["Project"]}-${var.tags["Environment"]}-aurora"
  database_name          = "s3_png_paths"
  source_region          = data.aws_region.current.name
  engine                 = "aurora-postgresql"
  engine_version         = "11.9"
  master_username        = var.rds_master_username
  master_password        = var.rds_master_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]
  skip_final_snapshot = true
  final_snapshot_identifier = "dummy-id" #https://github.com/hashicorp/terraform-provider-aws/issues/4910

  tags = var.tags
}

resource "aws_rds_cluster_instance" "aurora_cluster_instance" {
  identifier           = "${var.tags["Project"]}-${var.tags["Environment"]}-aurora-db"
  cluster_identifier   = aws_rds_cluster.this.id
  engine               = "aurora-postgresql"
  engine_version       = "11.9"
  instance_class       = var.instance_class
  db_subnet_group_name = aws_db_subnet_group.this.name

  tags = var.tags
}

resource "aws_db_subnet_group" "this" {
  name        = "${var.tags["Project"]}-${var.tags["Environment"]}-subnet-group"
  description = "Allowed subnets for Aurora DB cluster instances"
  subnet_ids = [var.vpc_module.sensitive_subnet_id,
  var.vpc_module.sensitive_dummy_subnet_id]

  tags = var.tags
}