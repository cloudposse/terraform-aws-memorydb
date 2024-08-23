output "id" {
  description = "The name of the MemoryDB cluster"
  value       = one(aws_memorydb_cluster.default.*.id)
}

output "arn" {
  description = "The ARN of the MemoryDB cluster"
  value       = one(aws_memorydb_cluster.default.*.arn)
}

output "cluster_endpoint" {
  description = "The endpoint of the MemoryDB cluster"
  value       = one(aws_memorydb_cluster.default.*.cluster_endpoint)
}

output "engine_patch_version" {
  description = "The Redis engine version"
  value       = one(aws_memorydb_cluster.default.*.engine_patch_version)
}

output "parameter_group_id" {
  description = "The name of the MemoryDB parameter group"
  value       = one(aws_memorydb_parameter_group.default.*.id)
}

output "parameter_group_arn" {
  description = "The ARN of the MemoryDB parameter group"
  value       = one(aws_memorydb_parameter_group.default.*.arn)
}

output "subnet_group_id" {
  description = "The name of the MemoryDB subnet group"
  value       = one(aws_memorydb_subnet_group.default.*.id)
}

output "subnet_group_arn" {
  description = "The ARN of the MemoryDB subnet group"
  value       = one(aws_memorydb_subnet_group.default.*.arn)
}

output "shards" {
  description = "The number of shards in the MemoryDB cluster"
  value       = one(aws_memorydb_cluster.default.*.shards)
}

output "admin_username" {
  description = "The username for the MemoryDB user"
  value       = one(aws_memorydb_user.admin.*.user_name)
}

output "admin_arn" {
  description = "The ARN of the MemoryDB user"
  value       = one(aws_memorydb_user.admin.*.arn)
}

output "admin_acl_arn" {
  description = "The ARN of the MemoryDB user's ACL"
  value       = one(aws_memorydb_acl.default.*.arn)
}

output "admin_password_ssm_parameter_name" {
  description = "The name of the SSM parameter storing the password for the MemoryDB user"
  value       = one(aws_ssm_parameter.admin_password.*.name)
}
