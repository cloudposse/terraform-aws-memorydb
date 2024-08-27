output "id" {
  description = "ID of the created MemoryDB cluster"
  value       = module.example.id
}

output "arn" {
  description = "ARN of the created MemoryDB cluster"
  value       = module.example.arn
}

output "cluster_endpoint" {
  description = "Endpoint of the created MemoryDB cluster"
  value       = module.example.cluster_endpoint
}

output "engine_patch_version" {
  description = "Engine patch version of the MemoryDB cluster"
  value       = module.example.engine_patch_version
}

output "parameter_group_id" {
  description = "ID of the MemoryDB cluster's parameter group"
  value       = module.example.parameter_group_id
}

output "parameter_group_arn" {
  description = "ARN of the MemoryDB cluster's parameter group"
  value       = module.example.parameter_group_arn
}

output "subnet_group_id" {
  description = "ID of the MemoryDB cluster's subnet group"
  value       = module.example.subnet_group_id
}

output "subnet_group_arn" {
  description = "ARN of the MemoryDB cluster's subnet group"
  value       = module.example.subnet_group_arn
}

output "shards" {
  description = "Shard details of the MemoryDB cluster"
  value       = module.example.shards
}

output "admin_username" {
  description = "Username of the MemoryDB admin"
  value       = module.example.admin_username
}

output "admin_arn" {
  description = "ARN of the MemoryDB admin"
  value       = module.example.admin_arn
}

output "admin_acl_arn" {
  description = "ARN of the MemoryDB admin's ACL"
  value       = module.example.admin_acl_arn
}

output "admin_password_ssm_parameter_name" {
  description = "SSM parameter name of the MemoryDB user's password"
  value       = module.example.admin_password_ssm_parameter_name
}
