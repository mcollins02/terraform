################################################################################
# VPC module
################################################################################
module "vpc" {
  source                           = "terraform-aws-modules/vpc/aws"

  name                             = "${var.vpc_name}"
  cidr                             = "${var.vpc_cidr}"

  azs                              = "${var.vpc_azs}"
  private_subnets                  = "${var.vpc_private_subnets}"
  public_subnets                   = "${var.vpc_public_subnets}"

  enable_nat_gateway               = true
  enable_dns_hostnames             = true
  enable_dns_support               = true

  enable_dhcp_options              = true
  dhcp_options_domain_name         = "${var.dns_domain}"
  dhcp_options_domain_name_servers = "${var.vpc_dns_server}"

  tags                             = "${var.tags}" 
}