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
account_role     = ""     # 'FullAdmin' role of account to deploy against i.e. "arn:aws:iam::<account #>:role/FullAdmin"
region           = ""     # AWS region to deploy in i.e. "us-east-1"
vpc_name         = ""     # Name of VPC i.e. "dev-owa"
dns_domain       = ""     # DNS domain to be used for VPC i.e. "dev-owa.xylem-cloud.com"
custom_domain    = false  # If using domain other than '<subdomain>.xylem-cloud.com', custom_domain = true
custom_zone_id   = ""     # If custom_domain = true, Route53 zone ID of primary public domain i.e. "Z2MO3ZW2ZI0YTV"
custom_zone_role = ""     # If custom_domain = true, 'FullAdmin' role of primary domain account i.e. "arn:aws:iam::152737658999:role/FullAdmin"
waf_enabled      = true   # Deploy WAF with external ALB and standard settings

################################################################################
# VPC vars
################################################################################
vpc_cidr            = ""  # available CIDR from https://xyleminc.atlassian.net/wiki/spaces/GDO/pages/229474714/Datacenter+Netblock+and+CIDR+Ranges i.e. "10.40.0.0/16"
vpc_azs             = []  # list of AZs in region i.e. ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
vpc_private_subnets = []  # list of private subnets (1 per AZ) i.e. ["10.40.60.0/23", "10.40.62.0/23", "10.40.64.0/23", "10.40.66.0/23"]
vpc_public_subnets  = []  # list of public subnets (1 per AZ) i.e.["10.40.2.0/24", "10.40.3.0/24", "10.40.4.0/24", "10.40.5.0/24"]
vpc_dns_server      = []  # .2 address in CIDR i.e. ["10.40.0.2"]

################################################################################
# EC2 vars
################################################################################
jenkins_enable                = true   # Create a Jenkins instance?
create_ebs_jenkins            = false  # Create a new EBS volume for Jenkins /home? 
create_ebs_jenkins_docker     = false  # Create a new EBS volume for Jenkins /docker
jenkins_ami                   = ""     # Golden AMI ID in region, available here https://xyleminc.atlassian.net/wiki/spaces/GDO/pages/231309859/Golden+AMI+ID
jenkins_ebs_az                = ""     # 'a' AZ of region, i.e. "us-east-1a"

ansible-control_enable        = true   # Create an Ansible instance?
ansible-control_ami           = ""     # Golden AMI ID in region, available here https://xyleminc.atlassian.net/wiki/spaces/GDO/pages/231309859/Golden+AMI+ID
ansible-control_instance_type = ""     # Instance type for Ansible instance, default = "t2.medium"

key_name                      = ""     # If creating Jenkins or Ansible, key pair must be manually created prior to deploy i.e. "owa-devops-dev"

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
    "terraform"                           = "true"    # always
    "env"                                 = ""        # i.e. "prod", "dev", "canada"
#   "kubernetes.io/cluster/owa-dev-eks-1" = "shared"  # example of required tags when using EKS or KOPS
}