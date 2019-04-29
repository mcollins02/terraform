# Define provider for creating peer in secops VPC
provider "aws" {
  alias   = "requester"
  profile = "default"
  region  = "${var.region}"
}

# Define provider for creating peer in new VPC
provider "aws" {
  alias   = "accepter"
  profile = "${var.profile}"
  region  = "${var.region}"
}

# Collect account info from new VPC
data "aws_caller_identity" "new" {
  provider = "aws.accepter"
}

# Initiate peering request from secops VPC
resource "aws_vpc_peering_connection" "peer" {
  provider = "aws.requester"

  peer_owner_id = "${data.aws_caller_identity.new.account_id}"
  peer_vpc_id   = "${module.vpc.vpc_id}"
  vpc_id        = "${var.secops_vpc_id}"
  auto_accept   = false

  tags {
    Name  = "secops_${var.vpc_name}"
    Owner = "${var.owner_tag}"
  }
}

# Accept request from new VPC
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider = "aws.accepter"

  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true

  tags {
    Name  = "secops_${var.vpc_name}"
    Owner = "${var.owner_tag}"
  }
}

# Set options for connection after it has been accepted
resource "aws_vpc_peering_connection_options" "requester" {
  provider = "aws.requester"

  vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.peer.id}"

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  provider = "aws.accepter"

  vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.peer.id}"

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}
# Add route from secops to new VPC network through VPC peer
resource "aws_route" "vpc_requester" {
  provider = "aws.requester"

  route_table_id         = "rtb-02e9365f6ab19800b"
  destination_cidr_block = "${var.vpc_cidr}"
  gateway_id             = "${aws_vpc_peering_connection_accepter.peer.id}"

  timeouts {
    create = "5m"
  }
}
# Add route from new VPC to secops through VPC peer
 resource "aws_route" "vpc_accepter" {
  provider = "aws.accepter"
  count = "${length(module.vpc.private_route_table_ids)}"
  route_table_id = "${element(module.vpc.private_route_table_ids, count.index)}"
  destination_cidr_block = "${var.secops_cidr}"
  gateway_id             = "${aws_vpc_peering_connection.peer.id}"

  timeouts {
    create = "5m"
  }
}