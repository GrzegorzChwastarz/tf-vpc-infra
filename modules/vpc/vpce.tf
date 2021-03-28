data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
}

data "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.this.id
  service_name = data.aws_vpc_endpoint_service.s3.service_name

  tags = merge({ Name = data.aws_vpc_endpoint_service.ssmmessages.service_name },
  var.tags)
}

data "aws_vpc_endpoint_service" "ssmmessages" {
  service = "ssmmessages"
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = aws_vpc.this.id
  service_name        = data.aws_vpc_endpoint_service.ssmmessages.service_name
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.ssm.id]
  subnet_ids          = aws_subnet.private.id
  private_dns_enabled = true

  tags = merge({ Name = data.aws_vpc_endpoint_service.ssmmessages.service_name },
  var.tags)
}

data "aws_vpc_endpoint_service" "ec2messages" {
  service = "ec2messages"
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.this.id
  service_name        = data.aws_vpc_endpoint_service.ec2messages.service_name
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.ssm.id]
  subnet_ids          = aws_subnet.private.id
  private_dns_enabled = true

  tags = merge({ Name = data.aws_vpc_endpoint_service.ec2messages.service_name },
  var.tags)
}






