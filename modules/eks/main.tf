module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.24"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnet_ids

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  cluster_enabled_log_types = var.cluster_enabled_log_types
  enable_irsa               = true

  eks_managed_node_groups = {
    for ng_name, ng in var.node_groups : ng_name => {
      instance_types = ng.instance_types
      capacity_type  = ng.capacity_type
      min_size       = ng.min_size
      max_size       = ng.max_size
      desired_size   = ng.desired_size
      ami_type       = try(ng.ami_type, null)
      labels         = try(ng.labels, {})
      taints         = try(ng.taints, [])
      subnet_ids     = try(ng.subnets, null)
    }
  }

  tags = var.tags
}