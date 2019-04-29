################################################################################
# EC2 Outputs
################################################################################
output "application_instance_id" {
    value = "${module.ec2_cluster.id}"
}

output "application_private_ip" {
    value = "${module.ec2_cluster.private_ip}"
}

output "application_alb_dns" {
    value = "${module.alb.dns_name}"
}

################################################################################
# Route53 Outputs
################################################################################
output "route_53_a_records" {
    value = "${aws_route53_record.application_route53_a_record.*.fqdn}"
}

output "alb_cname_public" {
    value = "${aws_route53_record.alb_cname_public.*.fqdn}"
}

output "alb_cname_private" {
    value = "${aws_route53_record.alb_cname_private.*.fqdn}"
}


################################################################################
# SG Outputs
################################################################################
output "alb_sg_id" {
  description = "Security group id for application load balancer"
  value       = "${aws_security_group.alb_sg.id}"
}

output "application_sg_id" {
  description = "Security group id for application used by ec2 instance"
  value       = "${aws_security_group.application_sg.id}"
}
