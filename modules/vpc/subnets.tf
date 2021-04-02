data "aws_region" "current" {}

resource "aws_subnet" "private" {
  availability_zone = "${data.aws_region.current.name}a"
  cidr_block        = var.private_subnet_cidr
  vpc_id            = aws_vpc.this.id

  tags = var.tags
}

resource "aws_subnet" "sensitive" {
  availability_zone = "${data.aws_region.current.name}a"
  cidr_block        = var.sensitive_subnet_cidr
  vpc_id            = aws_vpc.this.id

  tags = var.tags
}

# Aurora require subnet in 2 AZs so this is only for allowing DB deployment
resource "aws_subnet" "sensitive_dummy" {
  availability_zone = "${data.aws_region.current.name}b"
  cidr_block        = var.sensitive_dummy_subnet_cidr
  vpc_id            = aws_vpc.this.id

  tags = var.tags
}