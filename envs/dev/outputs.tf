output "eks" {
  value = {
    name      = module.eks.cluster_name
    endpoint  = module.eks.cluster_endpoint
    ca_data   = module.eks.cluster_ca
    oidc_arn  = module.eks.oidc_provider_arn
  }
}

output "vpc" {
  value = {
    vpc_id          = module.vpc.vpc_id
    private_subnets = module.vpc.private_subnet_ids
    public_subnets  = module.vpc.public_subnet_ids
  }
}

output "s3" {
  value = {
    bucket = module.s3.bucket_name
  }
}

# Persist outputs to artifacts/dev/outputs.json
resource "local_file" "outputs_json" {
  filename = "${path.module}/../../artifacts/${var.env}/outputs.json"
  content  = jsonencode({
    eks = {
      name     = module.eks.cluster_name
      endpoint = module.eks.cluster_endpoint
      ca_data  = module.eks.cluster_ca
      oidc_arn = module.eks.oidc_provider_arn
    }
    vpc = {
      vpc_id          = module.vpc.vpc_id
      private_subnets = module.vpc.private_subnet_ids
      public_subnets  = module.vpc.public_subnet_ids
    }
    s3 = {
      bucket = module.s3.bucket_name
    }
  })
}
