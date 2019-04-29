# Create initial public/private VPC + EIPs.  
# All variables in vars.tf
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.37.0"

  name = "${var.vpc_name}"

  cidr = "${var.vpc_cidr}"

  azs              = "${var.available_azs}"
  private_subnets  = "${var.priv_subnets}"
  public_subnets   = "${var.pub_subnets}"
  database_subnets = "${var.db_subnets}"

  create_database_subnet_group = true

  enable_nat_gateway     = true
  one_nat_gateway_per_az = true # <= Create 1 EIP per AZ, default limit is 5.  Use 'vpc_add' module to reuse existing EIPs.

  enable_vpn_gateway = false # <= May be useful in the future

  enable_s3_endpoint               = true # <= Keep S3 traffic private
  enable_dns_hostnames             = true
  enable_dhcp_options              = true
  dhcp_options_domain_name         = "${var.domain_name}"
  dhcp_options_domain_name_servers = ["127.0.0.1", "${var.dns_server}"]

  tags = {
    Owner    = "${var.owner_tag}"    # <= "Terraform" is default
    Customer = "${var.customer_tag}"
  }
}
