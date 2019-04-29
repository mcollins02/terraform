# Define Hybrid cloud connectivity to SaaS DCs
resource "aws_network_acl_rule" "hybrid_allow_in" {
  network_acl_id = "${data.terraform_remote_state.infra.nacl_id}"
  count          = "${length(var.hybrid_cidr)}"
  rule_number    = "${100 + count.index}"
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "${element(var.hybrid_cidr, count.index)}"
}
resource "aws_network_acl_rule" "hybrid_allow_out" {
  network_acl_id = "${data.terraform_remote_state.infra.nacl_id}"
  count          = "${length(var.hybrid_cidr)}"
  rule_number    = "${200 + count.index}"
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "${element(var.hybrid_cidr, count.index)}"
}
resource "aws_network_acl_rule" "hybrid_deny_in" {
  network_acl_id = "${data.terraform_remote_state.infra.nacl_id}"
  count          = "${length(var.hybrid_deny_cidr)}"
  rule_number    = "${300 + count.index}"
  egress         = false
  protocol       = -1
  rule_action    = "deny"
  cidr_block     = "${element(var.hybrid_deny_cidr, count.index)}"
}
resource "aws_network_acl_rule" "hybrid_deny_out" {
  network_acl_id = "${data.terraform_remote_state.infra.nacl_id}"
  count          = "${length(var.hybrid_deny_cidr)}"
  rule_number    = "${400 + count.index}"
  egress         = true
  protocol       = -1
  rule_action    = "deny"
  cidr_block     = "${element(var.hybrid_deny_cidr, count.index)}"
}