resource "aws_route53_record" "vault" {
  provider = "aws.dns"
  zone_id  = "${var.route53_zone_id}"
  name     = "minishift${var.name ? "-${var.name}" : ""}.${var.team}.${var.route53_domain}"
  type     = "A"
  ttl      = "300"
  records  = ["${aws_instance.minishift.private_ip}"]
}
