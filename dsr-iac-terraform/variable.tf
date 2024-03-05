variable "aws-region" {
  type = string
  description = "AWS Region"
  default = "us-east-1"
}

variable "vpc-cidr-block" {
  type = string
  description = "AWS VPC CIDR Range"
}