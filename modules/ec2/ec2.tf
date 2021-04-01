data "aws_region" "current" {}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.amazon-linux-2.image_id
  instance_type          = var.instance_type
  user_data      = data.template_cloudinit_config.config.rendered
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_migration_tier.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name

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

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "s3-migrator-installer.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.s3_migrator_installer.rendered
  }

  part {
    filename     = "postgresql-client-installer.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.postgresql_client_installer.rendered
  }

}

data "template_file" "s3_migrator_installer" {
  template = file("${path.root}/scripts/s3-migrator-installer.sh")

  vars = {
    artifacts_bucket_name = var.artifacts_bucket_name
    region                = data.aws_region.current.name
  }
}

data "template_file" "postgresql_client_installer" {
  template = file("${path.root}/scripts/postgresql-client-installer.sh")

  vars = {
    number_of_files      = var.number_of_files
    legacy_bucket_name   = var.legacy_bucket_name
    region               = data.aws_region.current.name
    db_region            = var.db_region
    db_instance_id       = var.db_instance_id
    db_username          = var.db_username
    db_password          = var.db_password
    db_endpoint_url      = var.db_endpoint_url
    db_name              = var.db_name
    number_of_db_records = var.number_of_db_records
  }
}

