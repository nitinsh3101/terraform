variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

# variable "private_subnet_cidr_block" {
#   description = "CIDR block for the subnet"
#   type        = string
# }

variable "public_subnet_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

# variable "private_subnet_zone" {
#   description = "Availability zone for the subnet"
#   type        = string
# }