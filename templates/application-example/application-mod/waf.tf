resource "aws_wafregional_web_acl_association" "alb_waf_association" {
  resource_arn = "${module.alb.load_balancer_id}"
  web_acl_id   = "${data.terraform_remote_state.vpc.waf_web_acl_id}"
}
