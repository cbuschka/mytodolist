provider "aws" {
  region = var.aws_region
  version = "~> 3.11.0"
}

data "aws_caller_identity" "current" {}

