variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "public_subnet_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "private_subnet_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "instance_ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for the EC2 instance"
  type        = string
}
