output "cluster_address" {
  value = aws_rds_cluster.this.endpoint
}

output "aurora_sg_id" {
  value = aws_security_group.this.id
}