terraform {
  backend "s3" {
    bucket         = "mycompany-terraform-state"     # << set your bucket
    key            = "eks/dev/terraform.tfstate"     # << unique per env
    region         = "ap-south-1"                    # << bucket region
    dynamodb_table = "terraform-locks"               # << shared lock table
    encrypt        = true
  }
}
