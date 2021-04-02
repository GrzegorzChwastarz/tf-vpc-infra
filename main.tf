module "vpc" {
  source    = "./modules/vpc"
  ec2_sg_id = module.ec2.ec2_sg_id

  tags = var.tags
}

module "ec2" {
  source             = "./modules/ec2"
  vpc_id             = module.vpc.vpc_id
  private_subnet_id  = module.vpc.private_subnet_id
  vpce_s3            = module.vpc.vpce_s3
  ssm_sg_id          = module.vpc.ssm_endpoint_sg_id
  rds_endpoint_sg_id = module.vpc.rds_endpoint_sg_id
  number_of_files    = var.number_of_files

  # User Data provision scripts variables
  artifacts_bucket_name = var.s3_buckets.s3_artifacts.s3_bucket_name
  legacy_bucket_name    = var.s3_buckets.s3_legacy.s3_bucket_name
  db_endpoint_url       = module.aurora.cluster_address
  db_sg_id              = module.aurora.aurora_sg_id
  db_instance_id        = module.aurora.db_instance_identifier
  db_name               = module.aurora.db_name
  db_password           = var.db_password
  db_username           = var.db_username
  number_of_db_records  = var.number_of_db_records

  tags = var.tags
}

module "s3" {
  source                = "./modules/s3"
  for_each              = var.s3_buckets
  s3_bucket_name        = each.value.s3_bucket_name
  artifacts_bucket_name = var.s3_buckets.s3_artifacts.s3_bucket_name

  tags = var.tags
}

module "aurora" {
  source              = "./modules/aurora"
  vpc_module          = module.vpc
  ec2_module          = module.ec2
  rds_master_username = var.db_username
  rds_master_password = var.db_password

  tags = var.tags
}

module "lambda" {
  source                        = "./modules/lambda"
  s3_lambda_event_source_bucket = var.s3_buckets.s3_legacy.s3_bucket_name
  s3_lambda_event_target_bucket = var.s3_buckets.s3_lambda_target.s3_bucket_name
  new_s3_prefix                 = var.new_s3_prefix
  old_s3_prefix                 = var.old_s3_prefix

  tags = var.tags
}
