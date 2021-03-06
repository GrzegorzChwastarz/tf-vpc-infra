output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "sensitive_subnet_id" {
  value = aws_subnet.sensitive.id
}

output "sensitive_dummy_subnet_id" {
  value = aws_subnet.sensitive_dummy.id
}

output "vpce_s3" {
  value = aws_vpc_endpoint.s3
}

output "ssm_endpoint_sg_id" {
  value = aws_security_group.ssm.id
}

output "rds_endpoint_sg_id" {
  value = aws_security_group.rds_endpoint.id
}