resource "aws_subnet" "private" {
  availability_zone = "eu-central-1c"
  cidr_block = var.private_subnet_cidr
  vpc_id     = aws_vpc.this.id

  tags = var.tags
}

resource "aws_subnet" "sensitive" {
  availability_zone = "eu-central-1c"
  cidr_block = var.sensitive_subnet_cidr
  vpc_id     = aws_vpc.this.id

  tags = var.tags
}

resource "aws_subnet" "sensitive_dummy" {
  availability_zone = "eu-central-1b"
  cidr_block = var.sensitive_dummy_subnet_cidr
  vpc_id = aws_vpc.this.id

  tags = var.tags
}