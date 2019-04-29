resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = ["${module.vpc.private_subnets}"]
  transit_gateway_id = "${data.terraform_remote_state.xylem-network.tgw_id}"
  vpc_id           = "${module.vpc.vpc_id}"
}