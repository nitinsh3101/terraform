resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr-block  
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "nitin-vpc-eks"
  }
}

resource "aws_subnet" "subnet-private" {
  count = 3
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.10.${count.index +1}.0/24"
  availability_zone = "${var.aws-region}${element(["a", "b", "c"], count.index)}"
  tags = {
    Name = "nitin-subnet-private-${count.index + 1}"
  }
}

resource "aws_subnet" "subnet-public" {
  count = 1
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.10.${count.index +5}.0/24"
  availability_zone = "${var.aws-region}${element(["a"], count.index)}"
  tags = {
    Name = "nitin-subnet-public-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat-gateway" {
  #allocation_id = aws_subnet.subnet-private[0].id
  connectivity_type = "private"
  subnet_id = aws_subnet.subnet-public[0].id
  tags = {
    Name = "nitin-nat-gateway"
  }
}

resource "aws_internet_gateway" "nitin_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "nitin-igw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }
  tags = {
    Name = "nitin-rt"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nitin_igw.id
  }
  tags = {
    Name = "nitin-rt-public"
  }
}

resource "aws_route_table_association" "rt-association" {
  count = length(aws_subnet.subnet-private)
  subnet_id = "${element(aws_subnet.subnet-private[*].id, count.index)}"
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "public-rt-association" {
  count = length(aws_subnet.subnet-public)
  subnet_id = "${element(aws_subnet.subnet-public[*].id, count.index)}"
  route_table_id = aws_route_table.public_rt.id
}

