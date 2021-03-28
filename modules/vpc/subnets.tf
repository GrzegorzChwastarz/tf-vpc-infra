resource "aws_subnet" "private" {
  cidr_block = var.private_subnet_cidr
  vpc_id     = aws_vpc.this.id

  tags = var.tags
}

resource "aws_subnet" "sensitive" {
  cidr_block = var.sensitive_subnet_cidr
  vpc_id     = aws_vpc.this.id

  tags = var.tags
}