module "vpc" {
  source    = "./modules/vpc"
  ec2_sg_id = module.ec2.ec2_sg_id

  tags = var.tags
}

module "ec2" {
  source            = "./modules/ec2"
  vpc_id            = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id
  vpce_s3           = module.vpc.vpce_s3
  ssm_sg_id         = module.vpc.ssm_endpoint_sg_id
  rds_endpoint_sg_id = module.vpc.rds_endpoint_sg_id

  # User Data provision scripts variables
  artifacts_bucket_name = var.s3_buckets.s3_artifacts.s3_bucket_name
  legacy_bucket_name    = var.s3_buckets.s3_legacy.s3_bucket_name
  db_endpoint_url       = module.aurora.cluster_address
  db_sg_id      = module.aurora.aurora_sg_id
  db_instance_id        = module.aurora.db_instance_identifier
  db_name               = module.aurora.db_name
  db_password           = var.db_password
  db_username           = var.db_username

  tags = var.tags
}

module "s3" {
  source         = "./modules/s3"
  for_each       = var.s3_buckets
  s3_bucket_name = each.value.s3_bucket_name
  artifacts_bucket_name = var.s3_buckets.s3_artifacts.s3_bucket_name

  tags = var.tags
}

module "aurora" {
  source              = "./modules/aurora"
  vpc_module          = module.vpc
  ec2_module          = module.ec2
  rds_master_username = var.db_username
  rds_master_password = var.db_password

  tags                = var.tags
}

module "lambda" {
  source = "./modules/lambda"
  artifacts_bucket_name = var.s3_buckets.s3_artifacts.s3_bucket_name

  tags = var.tags
}

/*module "sqs" {
  source = "./modules/sqs"
  sqs_name = "s3-event-lambda-sqs"
  sqs_dead_letter_name = "s3-event-lambda-dead-letter-sqs"
}*/