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

################################################################################
# ACM Outputs
################################################################################
output "aws_acm_certificate_arn" {
  description = "acm certificate arn"
  value       = "${aws_acm_certificate.acm_certificate.*.arn}"
}

###############################################################################
#WAF Outputs
###############################################################################
output "waf_web_acl_id" {
  description = "id for waf web acl"
  value       = "${aws_cloudformation_stack.this.outputs.WAFWebACL}"
}
