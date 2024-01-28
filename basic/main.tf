terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami = "ami-02f3f602d23f1659d" // AWS AMI 2023 machine
  instance_type = "t2.medium"
  tags = {
    Name = "first-tf-machine"
  }
}
