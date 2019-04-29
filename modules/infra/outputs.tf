################################################################################
# NACL/SG Outputs
################################################################################
output "nacl_id" {
  value = "${aws_network_acl.nacl.id}"
}

################################################################################
# VPC Outputs
################################################################################
output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}
output "private_subnets" {
  value = "${module.vpc.private_subnets}"
}
output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}
output "private_route_table_ids" {
  value = "${module.vpc.private_route_table_ids}"
}
################################################################################
# ACM Outputs
################################################################################
output "aws_acm_certificate_arn" {
  description = "acm certificate arn"
  value       = "${aws_acm_certificate.acm_certificate.arn}"
}

###############################################################################
# Security Group Outputs
###############################################################################
output "internal_ssh" {
  description = "Security group id for internal ssh"
  value       = "${aws_security_group.internal-ssh.id}"
}

###############################################################################
# Route53 Outputs
###############################################################################
output "private_zone_id" {
  value = "${aws_route53_zone.private.zone_id}"
  }

output "public_zone_id" {
  value = "${aws_route53_zone.public.zone_id}"
  }

###############################################################################
#WAF Outputs
###############################################################################
output "waf_web_acl_id" {
  description = "id for waf web acl"
  value       = "${aws_cloudformation_stack.this.outputs.WAFWebACL}"
}
