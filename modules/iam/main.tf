module "irsa_fluentbit" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.43"

  role_name                      = "${var.cluster_name}-fluentbit"
  attach_cloudwatch_logs_policy  = true
  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["aws-observability:fluent-bit"]
    }
  }
  tags = var.tags
}

module "irsa_cw_agent" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.43"

  role_name                        = "${var.cluster_name}-cwagent"
  attach_cloudwatch_agent_policy   = true
  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["amazon-cloudwatch:cloudwatch-agent"]
    }
  }
  tags = var.tags
}
