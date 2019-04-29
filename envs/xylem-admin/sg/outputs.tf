# Outputs #

output "xylem_admin_external_atlantis_alb_sg" {
  description = "external alb security group"
  value       = "${aws_security_group.xylem_admin_alb_external.id}"
}
