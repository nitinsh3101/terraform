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

resource "aws_nat_gateway" "nat-gateway" {
  #allocation_id = aws_subnet.subnet-private[0].id
  connectivity_type = "private"
  subnet_id = aws_subnet.subnet-private[0].id
  tags = {
    Name = "nitin-nat-gateway"
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

resource "aws_route_table_association" "rt-association" {
  count = length(aws_subnet.subnet-private)
  subnet_id = "${element(aws_subnet.subnet-private[*].id, count.index)}"
  route_table_id = aws_route_table.rt.id
}

resource "aws_vpc_endpoint" "eks-endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.us-east-1.eks"
  vpc_endpoint_type = "Interface"
  security_group_ids = [ aws_security_group.sg.id ]
  private_dns_enabled = true
}




