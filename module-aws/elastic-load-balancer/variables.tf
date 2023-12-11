# variable "vpc-id" {
#   type = string
#   description = "VPC ID"
# }
variable "security_groups_id" {
  type = list(string) 
  }

  # variable "public_availability_zone" {
  #   type = list(string)
  # }

variable "instance-id" {
  type = list(string)
}

variable "public-subnet" {
  type = list(string)
}