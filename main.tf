locals {
  enabled = module.this.enabled
}

resource "aws_memorydb_subnet_group" "default" {
  count = local.enabled && length(var.subnet_ids) > 0 ? 1 : 0

  name       = module.this.id
  subnet_ids = var.subnet_ids

  tags = module.this.tags
}

resource "aws_memorydb_cluster" "default" {
  count = local.enabled ? 1 : 0

  name                   = module.this.id
  acl_name               = var.tls_enabled ? one(aws_memorydb_acl.default[*].id) : "open-access"
  node_type              = var.node_type
  num_shards             = var.num_shards
  num_replicas_per_shard = var.num_replicas_per_shard
  tls_enabled            = var.tls_enabled

  engine_version             = var.engine_version
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  parameter_group_name       = one(aws_memorydb_parameter_group.default[*].id)
  subnet_group_name          = one(aws_memorydb_subnet_group.default[*].id)
  security_group_ids         = var.security_group_ids
  port                       = var.port

  maintenance_window       = var.maintenance_window
  snapshot_window          = var.snapshot_window
  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_arns            = var.snapshot_arns

  sns_topic_arn = var.sns_topic_arn

  tags = module.this.tags
}

resource "aws_memorydb_parameter_group" "default" {
  count = local.enabled && length(var.parameters) > 0 ? 1 : 0

  family = var.parameter_group_family
  name   = module.this.id

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.key
      value = parameter.value
    }
  }

  tags = module.this.tags
}

locals {
  user_password = var.admin_password != "" ? var.admin_password : one(random_password.password[*].result)
}

resource "random_password" "password" {
  count = var.admin_password == "" && local.enabled ? 1 : 0

  length           = 24
  special          = true
  override_special = "_%@"
}

resource "aws_memorydb_user" "admin" {
  count = local.enabled ? 1 : 0

  user_name     = var.admin_username
  access_string = "on ~* &* +@all"
  authentication_mode {
    type      = "password"
    passwords = [local.user_password]
  }

  tags = module.this.tags
}

resource "aws_ssm_parameter" "admin_password" {
  count = local.enabled && length(var.ssm_parameter_name) > 0 ? 1 : 0

  name   = var.ssm_parameter_name
  type   = "SecureString"
  value  = local.user_password
  key_id = var.ssm_kms_key_id

  tags = module.this.tags
}

resource "aws_memorydb_acl" "default" {
  count = local.enabled && var.tls_enabled ? 1 : 0

  name       = module.this.id
  user_names = aws_memorydb_user.admin[*].user_name
}
