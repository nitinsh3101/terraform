provider "aws" {
 region = var.aws-region 
}

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.23"
    }
  }
  required_version = ">=1.4.0"
}