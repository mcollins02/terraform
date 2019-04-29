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
account_role     = "arn:aws:iam::152737658999:role/FullAdmin"
region           = "ca-central-1"
vpc_name         = "prod-ca1"
dns_domain       = "prod-ca1.sensus-analytics.ca"
custom_domain    = true
custom_zone_id   = "Z2MO3ZW2ZI0YTV"
custom_zone_role = "arn:aws:iam::152737658999:role/FullAdmin"
waf_enabled      = false

################################################################################
# VPC vars
################################################################################
vpc_cidr            = "10.244.0.0/16"
vpc_azs             = ["ca-central-1a", "ca-central-1b"]
vpc_private_subnets = ["10.244.60.0/23", "10.244.62.0/23"]
vpc_public_subnets  = ["10.244.2.0/24", "10.244.3.0/24"]
vpc_dns_server      = ["10.244.0.2"]

################################################################################
# EC2 vars
################################################################################
create_ebs_jenkins            = true
create_ebs_jenkins_docker     = true
jenkins_ami                   = "ami-0ed4ec36d443908c8"
jenkins_enable                = true
jenkins_ebs_az                = "ca-central-1a"

ansible-control_enable        = false
ansible-control_ami           = "ami-0ed4ec36d443908c8"
ansible-control_instance_type = "t2.medium"

key_name                      = "sa-canada"  # Manually create key pair prior to running

################################################################################
# Hybrid Cloud networks
################################################################################
toronto_hybrid   = true
hybrid_deny_cidr = [
    "192.168.0.0/16",
    "172.20.0.0/16",
    "172.24.0.0/16",
    "172.28.0.0/16",
    "10.10.10.0/23",
    "10.15.14.0/23",
    "10.18.18.0/23"
  ]
hybrid_cidr      = [
    "172.28.51.0/24", 
    "172.28.52.0/24", 
    "172.28.53.0/24", 
    "172.28.55.0/24", 
    "172.29.10.0/24",
    "172.28.7.208/31"
  ]

################################################################################
# Tags
################################################################################
tags = {
    "terraform"                                      = "true"
    "env"                                            = "canada"
    "SubnetType"                                     = "Private"
    "kubernetes.io/cluster/kops.sensus-analytics.ca" = "shared"
    "kubernetes.io/role/elb"                         = "1"
    "kubernetes.io/role/internal-elb"                = "1"
}