terragrunt = {
  terraform {
    source = "git::ssh://git@bitbucket.org/sensusanalytics-dev/xylem-aws-terraform.git//modules//infra"
  }
  include = {
    path = "${find_in_parent_folders()}"
  }
}
###############################################################################
# Environment Definition
################################################################################
account_role     = "arn:aws:iam::199064309225:role/FullAdmin"
region           = "us-east-1"
vpc_name         = "dev-aquatalk"
dns_domain       = "dev-aquatalk.xylem-cloud.com"
custom_domain    = false
custom_zone_id   = ""
custom_zone_role = ""
waf_enabled      = true

################################################################################
# VPC vars
################################################################################
vpc_cidr            = "10.42.0.0/16"
vpc_azs             = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
vpc_private_subnets = ["10.42.60.0/23", "10.42.62.0/23", "10.42.64.0/23", "10.42.66.0/23"]
vpc_public_subnets  = ["10.42.2.0/24", "10.42.3.0/24", "10.42.4.0/24", "10.42.5.0/24"]
vpc_dns_server      = ["10.42.0.2"]

################################################################################
# EC2 vars
################################################################################
create_ebs_jenkins            = true
create_ebs_jenkins_docker     = true
jenkins_ami                   = "ami-07e32c1eab65d0bc8"
jenkins_enable                = true
jenkins_ebs_az                = "us-east-1a"

ansible-control_enable        = true
ansible-control_ami           = "ami-07e32c1eab65d0bc8"
ansible-control_instance_type = "t2.medium"

key_name                      = "aquatalk-devops-dev"  # Manually create key pair prior to running

################################################################################
# Hybrid Cloud networks
################################################################################
hybrid_enable    = false  # Allow hybrid connectivity to SaaS Datacenter?
hybrid_deny_cidr = []     # If hybrid_enable = true, list of SaaS networks that are restricted i.e.
#                   [
#     "192.168.0.0/16",
#     "172.20.0.0/16",
#     "172.24.0.0/16",
#     "172.28.0.0/16",
#     "10.10.10.0/23",
#     "10.15.14.0/23",
#     "10.18.18.0/23"
#   ]
hybrid_cidr      = []     # If hybrid_enable = true, list of SaaS networks to allow i.e.
#                  [
#    "172.29.10.0/24"
#    ]


################################################################################
# Transit Gateway
################################################################################
tgw_id = ""  # If hybrid_enable = true, ID of Transit Gateway i.e. "tgw-032ad20c93fdeb83c"

################################################################################
# Tags
################################################################################
tags = {
    "terraform"                           = "true"
    "env"                                 = "dev"
}