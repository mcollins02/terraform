################################################################################
# ACM Certificate
################################################################################
resource "aws_acm_certificate" "acm_certificate" {
  domain_name               = "*.${var.dns_domain}"
  validation_method         = "DNS"
  tags                      = "${var.tags}"
}

resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn 				= "${aws_acm_certificate.acm_certificate.arn}"
  validation_record_fqdns = [
 "${aws_route53_record.validation_route53_record.fqdn}",
 ]
}

resource "aws_route53_record" "validation_route53_record" {
  name    = "${aws_acm_certificate.acm_certificate.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.acm_certificate.domain_validation_options.0.resource_record_type}"
  zone_id = "${aws_route53_zone.public.zone_id}"
  records = ["${aws_acm_certificate.acm_certificate.domain_validation_options.0.resource_record_value}"]
  ttl     = "60"
}
