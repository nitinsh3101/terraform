output "public-subnet-id" {
  value = aws_subnet.public-subnet.id
}

# output "private-subnet-id" {
#   value = aws_subnet.nitin-subnet-private.id
# }

output "security-groups" {
  value = [ aws_security_group.nitin-sg.id ]
}

output "vpc-id" {
  value = aws_vpc.vpc.id
}

# output "public_availability_zone" {
#   value = [ aws_subnet.public-subnet.availability_zone ]
# }

output "public-subnet-ids" {
  value = [ aws_subnet.public-subnet.id ]
}