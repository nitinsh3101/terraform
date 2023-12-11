provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "nitin-terraform-tf-state"
    key = "module-aws/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "nitin-terraform-state-locking"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23"
    }
  }
  required_version = ">=1.4.0"
}

module "vpc" {
  source = "./vpc"

  # Input Variables
  vpc_cidr_block           = "10.10.0.0/16"
  public_subnet_cidr_block = "10.10.0.0/24"
  #   private_subnet_cidr_block = "10.10.1.0/24"
  public_subnet_zone = "us-east-1a"
  #   private_subnet_zone       = "us-east-1b"
}

module "ec2-instance" {
  source = "./ec2-instance"

  # Input Variables
  instance_ami     = "ami-0230bd60aa48260c6"
  instance_type    = "t2.micro"
  key_name         = "Cybage-Nitin-AWS"
  public_subnet_id = module.vpc.public-subnet-id
  #   private_subnet_id  = module.vpc.private-subnet-id
  security_groups_id = module.vpc.security-groups
  depends_on         = [module.vpc]
}

module "elastic-load-balancer" {
  source = "./elastic-load-balancer"

  security_groups_id = module.vpc.security-groups
  # public_availability_zone = module.vpc.public_availability_zone
  instance-id   = module.ec2-instance.instances
  public-subnet = module.vpc.public-subnet-ids
  depends_on    = [module.ec2-instance, module.vpc]
}

module "route53" {
  source  = "./route53"
  record = module.elastic-load-balancer.dns_name
  zone-id = module.route53.zone-id
}