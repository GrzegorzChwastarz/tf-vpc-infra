output "aurora_endpoint_addr" {
  value = module.aurora.cluster_address
}

output "aurora_db_username" {
  value = module.aurora.username
}

output "aurora_db_password" {
  value = module.aurora.password
}