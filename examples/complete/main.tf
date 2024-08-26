# Create basic vpc

module "vpc" {
  source                  = "cloudposse/vpc/aws"
  version                 = "2.1.0"
  ipv4_primary_cidr_block = var.vpc_cidr_block

  context = module.this.context
}

module "subnets" {
  source             = "cloudposse/dynamic-subnets/aws"
  version            = "2.3.0"
  vpc_id             = module.vpc.vpc_id
  availability_zones = var.availability_zones

  context = module.this.context
}

module "example" {
  source = "../.."

  node_type                  = var.node_type
  num_shards                 = var.num_shards
  num_replicas_per_shard     = var.num_replicas_per_shard
  tls_enabled                = var.tls_enabled
  engine_version             = var.engine_version
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  subnet_ids                 = module.subnets.private_subnet_ids
  security_group_ids         = [module.vpc.vpc_default_security_group_id]
  port                       = var.port
  maintenance_window         = var.maintenance_window

  snapshot_window          = var.snapshot_window
  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_arns            = var.snapshot_arns
  sns_topic_arn            = var.sns_topic_arn

  admin_password = var.admin_password
  admin_username = var.admin_username

  ssm_parameter_name = "/memorydb/admin_password"

  parameter_group_family = var.parameter_group_family
  parameters             = var.parameters

  context = module.this.context
}
