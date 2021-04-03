output "aurora_endpoint_addr" {
  value = module.aurora.cluster_address
}

output "aurora_db_username" {
  value = module.aurora.db_username
}

output "aurora_db_password" {
  value = module.aurora.db_password
}