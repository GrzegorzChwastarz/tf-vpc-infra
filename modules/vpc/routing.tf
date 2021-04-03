# There is no routing for summy sensitive as it will not be in use in this example anyway

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = var.tags
}

resource "aws_route_table_association" "private_association" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private.id
}

resource "aws_route_table" "sensitive" {
  vpc_id = aws_vpc.this.id

  tags = var.tags
}

resource "aws_route_table_association" "sensitive_association" {
  route_table_id = aws_route_table.sensitive.id
  subnet_id      = aws_subnet.sensitive.id
}