resource "aws_vpc_endpoint" "eks-endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.aws-region}.eks"
  security_group_ids = [ aws_security_group.sg.id ]
  vpc_endpoint_type = "Interface"
  subnet_ids = aws_subnet.subnet-private[*].id
  private_dns_enabled = true
  tags = {
    Name = "nitin-eks-endpoint"
  }
}

resource "aws_vpc_endpoint" "ec2-endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.aws-region}.ec2"
  security_group_ids = [ aws_security_group.sg.id ]
  vpc_endpoint_type = "Interface"
  subnet_ids = aws_subnet.subnet-private[*].id
  private_dns_enabled = true
  tags = {
    Name = "nitin-ec2-endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr-api-endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.aws-region}.ecr.api"
  security_group_ids = [ aws_security_group.sg.id ]
  vpc_endpoint_type = "Interface"
  subnet_ids = aws_subnet.subnet-private[*].id
  private_dns_enabled = true
  tags = {
    Name = "nitin-ecr-api-endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr-dkr-endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.aws-region}.ecr.dkr"
  security_group_ids = [ aws_security_group.sg.id ]
  vpc_endpoint_type = "Interface"
  subnet_ids = aws_subnet.subnet-private[*].id
  private_dns_enabled = true
  tags = {
    Name = "nitin-ecr-dkr-endpoint"
  }
}

resource "aws_vpc_endpoint" "s3-endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.aws-region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [ aws_route_table.rt.id ]
  tags = {
    Name = "nitin-s3-endpoint"
  }
}

resource "aws_vpc_endpoint" "elasticloadbalancing-endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.aws-region}.elasticloadbalancing"
  security_group_ids = [ aws_security_group.sg.id ]
  vpc_endpoint_type = "Interface"
  subnet_ids = aws_subnet.subnet-private[*].id
  private_dns_enabled = true
  tags = {
    Name = "nitin-elasticloadbalancing-endpoint"
  }
}

resource "aws_vpc_endpoint" "logs-endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.aws-region}.logs"
  security_group_ids = [ aws_security_group.sg.id ]
  vpc_endpoint_type = "Interface"
  subnet_ids = aws_subnet.subnet-private[*].id
  private_dns_enabled = true
  tags = {
    Name = "nitin-logs-endpoint"
  }
}

resource "aws_vpc_endpoint" "xray-endpoint" {
  vpc_id = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.aws-region}.xray"
  security_group_ids = [ aws_security_group.sg.id ]
  vpc_endpoint_type = "Interface"
  subnet_ids = aws_subnet.subnet-private[*].id
  private_dns_enabled = true
  tags = {
    Name = "nitin-xray-endpoint"
  }
}




