output "aws_acm_certificate_arn_xylem_admin" {
  description = "acm certificate arn"
  value       = "${aws_acm_certificate.acm_certificate_xylem_admin.arn}"
}
