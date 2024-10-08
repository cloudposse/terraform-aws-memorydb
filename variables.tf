variable "node_type" {
  description = "Node type for the MemoryDB cluster"
  type        = string
  default     = "db.r6g.large"
  nullable    = false
}

variable "num_shards" {
  description = "The number of shards in the cluster"
  type        = number
  default     = 1
  nullable    = false
}

variable "num_replicas_per_shard" {
  description = "The number of replicas per shard"
  type        = number
  default     = 1
  nullable    = false
}

variable "tls_enabled" {
  description = "Indicates whether Transport Layer Security (TLS) encryption is enabled for the cluster"
  type        = bool
  default     = true
  nullable    = false
}

variable "engine_version" {
  description = "The version of the Redis engine to use"
  type        = string
  default     = "6.2"
  nullable    = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the cluster during the maintenance window"
  type        = bool
  default     = true
  nullable    = false
}

variable "subnet_ids" {
  description = "List of subnet IDs for the MemoryDB cluster. Leave empty to use the default VPC subnets."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the MemoryDB cluster"
  type        = list(string)
  default     = []
  nullable    = false
}

variable "port" {
  description = "The port on which the cluster accepts connections"
  type        = number
  default     = 6379
  nullable    = false
}

variable "maintenance_window" {
  description = "The weekly time range during which system maintenance can occur"
  type        = string
  default     = null
}

variable "snapshot_window" {
  description = "The daily time range during which MemoryDB begins taking daily snapshots"
  type        = string
  default     = null
}

variable "snapshot_retention_limit" {
  description = "The number of days for which MemoryDB retains automatic snapshots before deleting them"
  type        = number
  default     = null
}

variable "snapshot_arns" {
  description = "List of ARNs for the snapshots to be restored. NOTE: destroys the existing cluster. Use for restoring."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "admin_username" {
  description = "The username for the MemoryDB admin"
  type        = string
  default     = "admin"
  nullable    = false
}

variable "admin_password" {
  description = "The password for the MemoryDB user. If empty, a random password will be generated."
  type        = string
  sensitive   = true
  default     = ""
  nullable    = false
}

variable "create_admin_user" {
  description = "Indicates whether to create an admin user for the MemoryDB cluster"
  type        = bool
  default     = true
  nullable    = false
}

variable "additional_users" {
  description = "List of additional users to create for the MemoryDB cluster"
  type        = list(string)
  default     = []
  nullable    = false
}

variable "ssm_kms_key_id" {
  description = "The KMS key ID to use for SSM parameter encryption. If not specified, the default key will be used."
  type        = string
  default     = null
}

variable "ssm_parameter_name" {
  description = "The name of the SSM parameter to store the password in. If not specified, the password will not be stored."
  type        = string
  default     = ""
  nullable    = false
}

variable "parameter_group_name" {
  description = "The name of the parameter group to associate with this cluster."
  type        = string
  default     = null
  nullable    = true
}

variable "parameter_group_family" {
  description = "The name of the parameter group family"
  type        = string
  default     = "memorydb_redis6"
  nullable    = false
}

variable "parameters" {
  description = "Key-value mapping of parameters to apply to the parameter group"
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic to send notifications to"
  type        = string
  default     = null
}
