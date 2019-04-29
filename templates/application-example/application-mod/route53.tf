################################################################################
# DEPLOY ALB CNAME
################################################################################

resource "aws_route53_record" "alb_cname_public" {
  count   = "${var.is_internal ? 0 : 1}"
  zone_id = "${data.terraform_remote_state.vpc.public_zone_id}"
  name    = "${var.app_name}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${module.alb.dns_name}"]
}

resource "aws_route53_record" "alb_cname_private" {
  count   = "${var.is_internal ? 1 : 0}"
  zone_id = "${data.terraform_remote_state.vpc.private_zone_id}"
  name    = "${var.app_name}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${module.alb.dns_name}"]
}

# ##################################################################################
# # EC2 Route53 A Record
# ##################################################################################
resource "aws_route53_record" "application_route53_a_record" {
  count   = "${var.instance_number}"
  zone_id = "${data.terraform_remote_state.vpc.private_zone_id}"
  name    = "${var.app_name}-${count.index + 1}"
  type    = "A"
  ttl     = "60"
  records = ["${element(module.ec2_cluster.private_ip, count.index)}"]
}
