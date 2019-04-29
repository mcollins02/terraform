terragrunt = {
  terraform {
    source = "git::ssh://git@bitbucket.org/sensusanalytics-dev/xylem-aws-terraform.git//modules//infra"
  }
  include = {
    path = "${find_in_parent_folders()}"
  }
}
################################################################################
# Environment Definition
################################################################################
account_role     = "arn:aws:iam::383850777655:role/FullAdmin"
region           = "eu-central-1"
vpc_name         = "one-controller"
dns_domain       = "onecontroller.xylem-cloud.com"
custom_domain    = false
custom_zone_id   = ""
custom_zone_role = ""
waf_enabled      = false

################################################################################
# VPC vars
################################################################################
vpc_cidr            = "10.44.0.0/16"
vpc_azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
vpc_private_subnets = ["10.44.60.0/23", "10.44.62.0/23", "10.44.64.0/23"]
vpc_public_subnets  = ["10.44.2.0/24", "10.44.3.0/24", "10.44.4.0/24"]
vpc_dns_server      = ["10.44.0.2"]

################################################################################
# EC2 vars
################################################################################
create_ebs_jenkins            = false
create_ebs_jenkins_docker     = false
jenkins_enable                = false
ansible-control_enable        = false
key_name                      = "onecontroller-devops"

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
}
