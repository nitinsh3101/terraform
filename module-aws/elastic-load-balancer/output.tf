output "dns_name" {
  value = [ aws_elb.lb.dns_name ]
}