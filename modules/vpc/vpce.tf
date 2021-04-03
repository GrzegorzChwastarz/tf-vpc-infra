# s3 gateway endpoint for calls made from lambda and EC2 migration instance + ability to use yum without connection to the internet
# ssm/ssmmessages/ec2messages endpoints allow ssm session manager connection without Internet/Nat Gateway
# rds endpoint to connect between private and sensitive subnet

data "aws_vpc_endpoint_service" "s3" {
  service      = "s3"
  service_type = "Gateway"
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.this.id
  service_name      = data.aws_vpc_endpoint_service.s3.service_name
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private.id]

  tags = merge({ Name = data.aws_vpc_endpoint_service.s3.service_name },
  var.tags)
}

data "aws_vpc_endpoint_service" "ssm" {
  service = "ssm"
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.this.id
  service_name        = data.aws_vpc_endpoint_service.ssm.service_name
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.ssm.id]
  subnet_ids          = [aws_subnet.private.id]
  private_dns_enabled = true

  tags = merge({ Name = data.aws_vpc_endpoint_service.ssm.service_name },
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
  subnet_ids          = [aws_subnet.private.id]
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
  subnet_ids          = [aws_subnet.private.id]
  private_dns_enabled = true

  tags = merge({ Name = data.aws_vpc_endpoint_service.ec2messages.service_name },
  var.tags)
}

data "aws_vpc_endpoint_service" "rds" {
  service = "rds"
}

resource "aws_vpc_endpoint" "rds" {
  vpc_id              = aws_vpc.this.id
  service_name        = data.aws_vpc_endpoint_service.rds.service_name
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.rds_endpoint.id]
  subnet_ids          = [aws_subnet.private.id]
  private_dns_enabled = true

  tags = merge({ Name = data.aws_vpc_endpoint_service.ec2messages.service_name },
  var.tags)
}


