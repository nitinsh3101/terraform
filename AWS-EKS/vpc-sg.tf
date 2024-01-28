resource "aws_security_group" "sg" {
  name = "nitin-sg"
  vpc_id = aws_vpc.vpc.id
   ingress {
    from_port   = 0
    to_port     = 65500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nitin-sg"
  }
}