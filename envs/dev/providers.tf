# Pull in shared AWS provider variable contract
module "global" {
  source = "../../global"
}

# Data sources to get connection material after the cluster exists
data "aws_eks_cluster" "this" { name = module.eks.cluster_name }
data "aws_eks_cluster_auth" "this" { name = module.eks.cluster_name }

# Configure k8s/helm providers against the new cluster
provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

# Deploy observability add-ons
module "observability" {
  source            = "../../modules/observability"
  cluster_name      = module.eks.cluster_name
  region            = var.aws_region
  fluentbit_role_arn= module.iam.fluentbit_role_arn
  cw_agent_role_arn = module.iam.cw_agent_role_arn
}
