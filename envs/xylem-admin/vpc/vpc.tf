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
  dhcp_options_domain_name         = "admin.xylem-cloud.com"
  dhcp_options_domain_name_servers = ["10.3.0.2"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# Security group for scanning/logs
module "secops_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.1.0"

  name        = "secops"
  description = "allow ports for scanning and log delivery"

  tags {
    Terraform = "true"
  }

  vpc_id = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "nessus scanning"
      cidr_blocks = "10.2.0.0/20"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 514
      to_port     = 514
      protocol    = "udp"
      description = "log delivery"
      cidr_blocks = "10.2.0.0/20"
    },
  ]
}

