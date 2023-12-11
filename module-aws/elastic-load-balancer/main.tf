resource "aws_elb" "lb" {
  name = "nitin-terraform-lb"
  # availability_zones = var.public_availability_zone
  internal = false
  subnets = var.public-subnet
  security_groups = var.security_groups_id
    

  listener {
    instance_port = 8080
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    target = "HTTP:8080/"
    interval = 60
  }

  instances = var.instance-id 

  tags = {
    Name = "nitin-terraform-lb"
  }
}