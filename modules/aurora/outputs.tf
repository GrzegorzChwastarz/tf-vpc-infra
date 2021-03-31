output "cluster_address" {
  value = aws_rds_cluster_instance.aurora_cluster_instance.endpoint
}

output "username" {
  value = aws_rds_cluster.this.master_username
}

output "password" {
  value = aws_rds_cluster.this.master_password
}

output "aurora_sg_id" {
  value = aws_security_group.this.id
}