output "id" {
  description = "ID of the created MemoryDB cluster"
  value       = module.memorydb.id
}

output "arn" {
  description = "ARN of the created MemoryDB cluster"
  value       = module.memorydb.arn
}

output "cluster_endpoint" {
  description = "Endpoint of the created MemoryDB cluster"
  value       = module.memorydb.cluster_endpoint
}

output "engine_patch_version" {
  description = "Engine patch version of the MemoryDB cluster"
  value       = module.memorydb.engine_patch_version
}

output "parameter_group_id" {
  description = "ID of the MemoryDB cluster's parameter group"
  value       = module.memorydb.parameter_group_id
}

output "parameter_group_arn" {
  description = "ARN of the MemoryDB cluster's parameter group"
  value       = module.memorydb.parameter_group_arn
}

output "subnet_group_id" {
  description = "ID of the MemoryDB cluster's subnet group"
  value       = module.memorydb.subnet_group_id
}

output "subnet_group_arn" {
  description = "ARN of the MemoryDB cluster's subnet group"
  value       = module.memorydb.subnet_group_arn
}

output "shards" {
  description = "Shard details of the MemoryDB cluster"
  value       = module.memorydb.shards
}

output "admin_username" {
  description = "Username of the MemoryDB admin"
  value       = module.memorydb.admin_username
}

output "admin_arn" {
  description = "ARN of the MemoryDB admin"
  value       = module.memorydb.admin_arn
}

output "admin_acl_arn" {
  description = "ARN of the MemoryDB admin's ACL"
  value       = module.memorydb.admin_acl_arn
}

output "admin_password_ssm_parameter_name" {
  description = "SSM parameter name of the MemoryDB user's password"
  value       = module.memorydb.admin_password_ssm_parameter_name
}
