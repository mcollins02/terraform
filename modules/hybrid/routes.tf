resource "aws_route" "hybrid0" {
  count                     = "${length(var.hybrid_cidr)}"
  route_table_id            = "${data.terraform_remote_state.infra.private_route_table_ids[0]}"
  destination_cidr_block    = "${element(var.hybrid_cidr, count.index)}"
  transit_gateway_id        = "${data.terraform_remote_state.xylem-network.tgw_id}"
}
resource "aws_route" "hybrid1" {
  count                     = "${length(var.hybrid_cidr)}"
  route_table_id            = "${data.terraform_remote_state.infra.private_route_table_ids[1]}"
  destination_cidr_block    = "${element(var.hybrid_cidr, count.index)}"
  transit_gateway_id        = "${data.terraform_remote_state.xylem-network.tgw_id}"
}