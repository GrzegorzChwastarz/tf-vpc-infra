output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "vpce_s3" {
  value = aws_vpc_endpoint.s3
}