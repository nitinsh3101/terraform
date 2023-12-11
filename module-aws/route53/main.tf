data "aws_route53_zone" "hosted-zone" {
  name = "dockeroncloud.com"
}
resource "aws_route53_record" "dns-record" {
  name = "terraform.dockeroncloud.com"
  type = "CNAME"
  records = var.record
  ttl = "60"
  zone_id = var.zone-id
}