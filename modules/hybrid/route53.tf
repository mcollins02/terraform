################################################################################
# Route53 Outbound Rules
################################################################################

resource "aws_route53_resolver_rule_association" "tor-flexnet" {
  count            = "${var.toronto_hybrid ? 1 : 0}"
  resolver_rule_id = "${data.terraform_remote_state.xylem-network.tor-flexnet_rule_id[0]}"
  vpc_id           = "${data.terraform_remote_state.infra.vpc_id}"
}
resource "aws_route53_resolver_rule_association" "ral-flexnet" {
  count            = "${var.raleigh_hybrid ? 1 : 0}"
  resolver_rule_id = "${data.terraform_remote_state.xylem-network.ral-flexnet_rule_id[0]}"
  vpc_id           = "${data.terraform_remote_state.infra.vpc_id}"
}
resource "aws_route53_resolver_rule_association" "boi-flexnet" {
  count            = "${var.boise_hybrid ? 1 : 0}"
  resolver_rule_id = "${data.terraform_remote_state.xylem-network.boi-flexnet_rule_id[0]}"
  vpc_id           = "${data.terraform_remote_state.infra.vpc_id}"
}

