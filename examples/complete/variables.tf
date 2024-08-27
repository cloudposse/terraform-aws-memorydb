variable "region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "The availability zones to deploy to"
  type        = list(string)
}

variable "node_type" {
  description = "Node type for the MemoryDB cluster"
  type        = string
  default     = "db.r6g.large"
}

variable "num_shards" {
  description = "The number of shards in the cluster"
  type        = number
  default     = 1
}

variable "num_replicas_per_shard" {
  description = "The number of replicas per shard"
  type        = number
  default     = 1
}

variable "tls_enabled" {
  description = "Indicates whether Transport Layer Security (TLS) encryption is enabled for the cluster"
  type        = bool
  default     = true
}

variable "engine_version" {
  description = "The version of the Redis engine to use"
  type        = string
  default     = "6.x"
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the cluster during the maintenance window"
  type        = bool
  default     = true
}

# tflint-ignore: terraform_unused_declarations
variable "subnet_ids" {
  description = "List of subnet IDs for the MemoryDB cluster. Leave empty to use the default VPC subnets."
  type        = list(string)
  default     = []
}

# tflint-ignore: terraform_unused_declarations
variable "security_group_ids" {
  description = "List of security group IDs for the MemoryDB cluster"
  type        = list(string)
  default     = []
}

variable "port" {
  description = "The port on which the cluster accepts connections"
  type        = number
  default     = 6379
}

variable "maintenance_window" {
  description = "The weekly time range during which system maintenance can occur"
  type        = string
  default     = "sun:05:00-sun:09:00"
}

variable "snapshot_window" {
  description = "The daily time range during which MemoryDB begins taking daily snapshots"
  type        = string
  default     = "05:00-09:00"
}

variable "snapshot_retention_limit" {
  description = "The number of days for which MemoryDB retains automatic snapshots before deleting them"
  type        = number
  default     = 5
}

variable "snapshot_arns" {
  description = "List of ARNs for the snapshots to be restored. NOTE: destroys the existing cluster. Use for restoring."
  type        = list(string)
  default     = []
}

variable "admin_username" {
  description = "The username for the MemoryDB user"
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "The password for the MemoryDB user. If empty, a random password will be generated."
  type        = string
  sensitive   = true
  default     = ""
}

# tflint-ignore: terraform_unused_declarations
variable "ssm_kms_key_id" {
  description = "The KMS key ID to use for SSM parameter encryption. If not specified, the default key will be used."
  type        = string
  default     = null
  nullable    = true
}

variable "ssm_parameter_name" {
  description = "The name of the SSM parameter to store the password in. If not specified, the password will not be stored."
  type        = string
  default     = ""
  nullable    = false
}

variable "parameter_group_family" {
  description = "The name of the parameter group family"
  type        = string
  default     = "redis6.x"
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
