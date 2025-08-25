locals {
  tags = merge(var.tags, {
    "terraform:env" = var.env
    "system"        = "eks-foundation"
  })
}

# VPC
module "vpc" {
  source           = "../../modules/vpc"
  name             = "${var.name}-${var.env}"
  cidr             = var.cidr
  azs              = var.azs
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  tags             = local.tags
}

# EKS
module "eks" {
  source              = "../../modules/eks"
  cluster_name        = var.cluster_name
  cluster_version     = var.cluster_version
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  node_groups         = var.node_groups                   # << NEW
  cluster_enabled_log_types = var.ha_enabled ?            # optional: same logs either way
    ["api","audit","authenticator","controllerManager","scheduler"] :
    ["api","audit","authenticator"]                       # dev: fewer logs if you want
  tags = local.tags
}

# IAM (IRSA) for observability
module "iam" {
  source            = "../../modules/iam"
  cluster_name      = module.eks.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  tags              = local.tags
}

# S3 application bucket
module "s3" {
  source             = "../../modules/s3"
  bucket_name        = var.app_bucket
  enable_access_logs = var.enable_access_logs
  tags               = local.tags
}
