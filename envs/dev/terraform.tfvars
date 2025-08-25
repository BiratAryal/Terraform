env        = "dev"
aws_region = "ap-south-1"

# HA toggle (dev off)
ha_enabled = false

# VPC: 2 AZs only
name            = "workloads"
cidr            = "10.30.0.0/16"
azs             = ["ap-south-1a","ap-south-1b"]                  # 2 AZs
public_subnets  = ["10.30.1.0/24","10.30.2.0/24"]
private_subnets = ["10.30.11.0/24","10.30.12.0/24"]

# EKS
cluster_name    = "eks-dev"
cluster_version = "1.30"

# Node groups: single small group
node_groups = {
  default = {
    instance_types = ["t3.large"]
    capacity_type  = "ON_DEMAND"
    min_size       = 1
    max_size       = 3
    desired_size   = 2
    labels         = { env = "dev" }
  }
}

# S3 app bucket (unique per env)
app_bucket         = "acme-dev-app-bucket-123456"
enable_access_logs = true

tags = {
  owner        = "platform"
  cost-center  = "infra"
}
