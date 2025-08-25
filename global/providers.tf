# Shared AWS provider. Region is provided at env root via tfvars or TF_VAR_aws_region.
provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
}
