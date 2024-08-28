region = "us-east-2"

namespace = "eg"

environment = "ue2"

stage = "test"

name = "memorydb"

availability_zones = ["us-east-2a", "us-east-2b"]

vpc_cidr_block = "172.16.0.0/16"

node_type = "db.r6g.large"

num_shards = 1

num_replicas_per_shard = 1

tls_enabled = true

engine_version = "6.2"

auto_minor_version_upgrade = true

port = 6379

maintenance_window = null

snapshot_window = null

snapshot_retention_limit = null

snapshot_arns = []

sns_topic_arn = null

admin_password = ""

# causes a race condition between terraform and opentofu. So we randomize it
# admin_username = "admin"

# also conflicts during parallel runs of terraform and opentofu
# ssm_parameter_name = "/memorydb/admin_password"

parameter_group_family = "memorydb_redis6"

parameters = {
  "activedefrag" = "yes"
}
