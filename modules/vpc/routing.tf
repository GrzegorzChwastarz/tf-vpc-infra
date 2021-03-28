resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = var.tags
}

resource "aws_route_table" "sensitive" {
  vpc_id = aws_vpc.this.id

  tags = var.tags
}