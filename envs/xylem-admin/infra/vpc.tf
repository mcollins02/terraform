# VPC creation
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "admin"
  cidr = "10.3.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  private_subnets = ["10.3.60.0/23", "10.3.62.0/23", "10.3.64.0/23", "10.3.66.0/23"]
  public_subnets  = ["10.3.2.0/24", "10.3.3.0/24", "10.3.4.0/24", "10.3.5.0/24"]

  enable_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_dhcp_options              = true
  dhcp_options_domain_name         = "${var.dns-domain}"
  dhcp_options_domain_name_servers = ["10.3.0.2"]

  tags = {
    terraform = "true"
    env = "admin"
  }
}

