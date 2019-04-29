# Create NACL
resource "aws_network_acl" "nacl" {
  vpc_id     = "${module.vpc.vpc_id}"
  subnet_ids = [
      "${module.vpc.private_subnets}",
      "${module.vpc.public_subnets}"
  ]
}

# Allow all other traffic
resource "aws_network_acl_rule" "allow_all_in" {
  network_acl_id = "${aws_network_acl.nacl.id}"
  rule_number    = "32000"
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}
resource "aws_network_acl_rule" "allow_all_out" {
  network_acl_id = "${aws_network_acl.nacl.id}"
  rule_number    = "32001"
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}