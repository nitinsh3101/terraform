variable "instance_ami" {
  default = "ami-0230bd60aa48260c6"
  description = "AMI instance name"
  type = string
}

variable "instance_type" {
  default = "t2.micro"
  description = "Type of instance"
  type = string
}

variable "key_name" {
  default = "Cybage-Nitin-AWS"
  description = "Instance Key Name"
  type = string
}

variable "public_subnet_id" {
  type = string
  description = "Public subnet id"
}

# variable "private_subnet_id" {
#   type = string
#   description = "Private subnet id"
# }

variable "security_groups_id" {
  type = list(string) 
  }