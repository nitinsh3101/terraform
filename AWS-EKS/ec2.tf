resource "aws_instance" "app_server" {
  ami = "ami-02bc22c53ba944022" 
  instance_type = "t2.micro"
  tags = {
    Name = "nitin-eks-access"
  }
  subnet_id = aws_subnet.subnet-public[0].id
  key_name = "Cybage-Nitin-AWS"
  security_groups = [ aws_security_group.sg.id ]
}