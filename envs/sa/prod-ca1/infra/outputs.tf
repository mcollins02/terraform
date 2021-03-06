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
# NACL/SG Outputs
################################################################################
output "nacl_id" {
  value = "${aws_network_acl.nacl.id}"
}

################################################################################
# ACM Outputs
################################################################################
output "aws_acm_certificate_arn" {
  description = "acm certificate arn"
  value       = "${aws_acm_certificate.acm_certificate.*.arn}"
}

################################################################################
# Route53 Outputs
################################################################################
output "r53_inbound_endpoints" {
  value = "${aws_route53_resolver_endpoint.inbound.ip_address}"
}
