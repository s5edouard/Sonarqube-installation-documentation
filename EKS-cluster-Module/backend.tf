terraform {
  backend "s3" {
    bucket         = "2108-devops-bfa-final-tf-state"
    key            = "aws-terraform/vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "2108-devops-bfa-final-tf-state-lock"
  }
}