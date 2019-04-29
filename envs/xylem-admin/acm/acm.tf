################################################################################
# ACM Certificate
################################################################################
resource "aws_acm_certificate" "acm_certificate_xylem_admin" {
  domain_name               = "*.admin.xylem-cloud.com"
  validation_method         = "DNS"
tags {
    terraform = "true"
  }
}


resource "aws_acm_certificate_validation" "acm_certificate_validation_xylem_admin" {
 certificate_arn 				= "${aws_acm_certificate.acm_certificate_xylem_admin.arn}"
validation_record_fqdns = [
 "${aws_route53_record.validation_route53_record_xylem_admin.fqdn}",
 ]
}

resource "aws_route53_record" "validation_route53_record_xylem_admin" {
name    	= "${aws_acm_certificate.acm_certificate_xylem_admin.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.acm_certificate_xylem_admin.domain_validation_options.0.resource_record_type}"
  zone_id = "Z2WOYABYASZ5CS"
  records = ["${aws_acm_certificate.acm_certificate_xylem_admin.domain_validation_options.0.resource_record_value}"]
  ttl     = "60"
}
