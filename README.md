# Directory Structure
terraform/
├─ bootstrap/                      # one-time infra for S3 state bucket + DynamoDB locks
│  ├─ main.tf
│  ├─ variables.tf
│  └─ outputs.tf
├─ global/
│  ├─ versions.tf                  # Terraform + provider constraints
│  └─ providers.tf                 # shared AWS provider (region via env variables or tfvars)
├─ modules/
│  ├─ vpc/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  ├─ eks/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  ├─ iam/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  ├─ s3/
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  └─ outputs.tf
│  └─ observability/
│     ├─ main.tf
│     ├─ variables.tf
│     └─ outputs.tf
├─ envs/
│  ├─ dev/
│  │  ├─ backend.tf                # env-specific remote state (S3+DDB)
│  │  ├─ main.tf                   # root orchestrator
│  │  ├─ variables.tf
│  │  ├─ terraform.tfvars
│  │  ├─ providers.tf              # k8s + helm wired to EKS
│  │  └─ outputs.tf                # + writes artifacts/dev/outputs.json
│  ├─ stage/
│  │  ├─ backend.tf
│  │  ├─ main.tf
│  │  ├─ variables.tf
│  │  ├─ terraform.tfvars
│  │  ├─ providers.tf
│  │  └─ outputs.tf
│  └─ prod/
│     ├─ backend.tf
│     ├─ main.tf
│     ├─ variables.tf
│     ├─ terraform.tfvars
│     ├─ providers.tf
│     └─ outputs.tf
└─ README.md

# Need to change the architecture for the digital ocean.