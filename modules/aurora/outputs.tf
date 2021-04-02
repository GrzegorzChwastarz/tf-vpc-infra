output "cluster_address" {
  value = aws_rds_cluster_instance.aurora_cluster_instance.endpoint
}

output "db_username" {
  value = aws_rds_cluster.this.master_username
}

output "db_password" {
  value = aws_rds_cluster.this.master_password
}

output "db_name" {
  value = aws_rds_cluster.this.database_name
}

output "aurora_sg_id" {
  value = aws_security_group.this.id
}

output "db_instance_identifier" {
  value = aws_rds_cluster_instance.aurora_cluster_instance.identifier
}