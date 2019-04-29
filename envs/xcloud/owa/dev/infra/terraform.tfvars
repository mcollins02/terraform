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
account_role     = ""
region           = "us-east-1"
vpc_name         = ""
dns_domain       = ""
custom_domain    = false
custom_zone_id   = ""
custom_zone_role = ""
waf_enabled      = true

################################################################################
# VPC vars
################################################################################
vpc_cidr            = "10.40.0.0/16"
vpc_azs             = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
vpc_private_subnets = ["10.40.60.0/23", "10.40.62.0/23", "10.40.64.0/23", "10.40.66.0/23"]
vpc_public_subnets  = ["10.40.2.0/24", "10.40.3.0/24", "10.40.4.0/24", "10.40.5.0/24"]
vpc_dns_server      = ["10.40.0.2"]

################################################################################
# EC2 vars
################################################################################
create_ebs_jenkins            = false
create_ebs_jenkins_docker     = false
jenkins_ami                   = "ami-02eac2c0129f6376b"
jenkins_enable                = true
jenkins_ebs_az                = "us-east-1a"

ansible-control_enable        = true
ansible-control_ami           = "ami-02eac2c0129f6376b"
ansible-control_instance_type = "t2.medium"

key_name                      = ""

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
    "kubernetes.io/cluster/owa-dev-eks-1" = "shared"
}
