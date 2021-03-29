resource "aws_instance" "this" {
  ami                         = data.aws_ami.amazon-linux-2.image_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2_migration_tier.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name

  root_block_device {
    volume_size = var.ec2_volume_size
  }

  tags = merge(
  var.tags,
  {
    Name = "${var.tags["Project"]}-${var.tags["Environment"]}-${var.ec2_name}"
  }
  )
}

