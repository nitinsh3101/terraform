resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "Nitin-new-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = var.public_subnet_zone
  tags = {
    Name = "nitin-public-subnet"
  }
}

# resource "aws_subnet" "nitin-subnet-private" {
#   vpc_id = aws_vpc.vpc.id
#   cidr_block = var.private_subnet_cidr_block
#   availability_zone = var.private_subnet_zone
#   tags = {
#     Name = "nitin-subnet-private"
#   }
# }

resource "aws_internet_gateway" "nitin_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "nitin-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nitin_igw.id
  }
  tags = {
    Name = "nitin-rt-public"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "nitin-sg" {
  name = "nitin-sg"
  vpc_id = aws_vpc.vpc.id
   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nitin-sg"
  }
}

# resource "aws_nat_gateway" "nitin_nat_gateway" {
#   connectivity_type = "private"
#   subnet_id      = aws_subnet.nitin-subnet-private.id
#   tags = {
#     Name = "nitin-nat-gw"
#   }
# }

# resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.nitin_nat_gateway.id
#   }
#   tags = {
#     Name = "nitin-rt-private"
#   }
# }

# resource "aws_route_table_association" "private_subnet_association" {
#   subnet_id      = aws_subnet.nitin-subnet-private.id
#   route_table_id = aws_route_table.private_route_table.id
# }

