resource "aws_instance" "ec2-instance" {
  count = 2
  ami = var.instance_ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.public_subnet_id
  associate_public_ip_address = true
  security_groups = var.security_groups_id
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello World" > index.html
              python3 -m http.server 8080 &
              EOF
  tags = {
    Name = "nitin-terraform-${count.index}"
  }
}

# resource "aws_instance" "ec2-instance-1" {
#   ami = var.instance_ami
#   instance_type = var.instance_type
#   key_name = var.key_name
#   subnet_id = var.private_subnet_id
#   security_groups = var.security_groups_id
#   tags = {
#     Name = "nitin-terraform-private"
#   }
# }