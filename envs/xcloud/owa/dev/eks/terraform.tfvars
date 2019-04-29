terragrunt = {
  terraform {
    source = "git::ssh://git@bitbucket.org/sensusanalytics-dev/xylem-aws-terraform.git//modules//eks"
  }
  include = {
    path = "${find_in_parent_folders()}"
  }
}
################################################################################
# Environment Definition
################################################################################
account_role = ""
region       = "us-east-1"

################################################################################
# EKS vars
################################################################################
eks_cluster_name  = "owa-dev-eks-1"
eks_key_name      = "owa-devops-dev"
eks_pre_userdata  = "echo '{ \"log-driver\": \"json-file\", \"log-opts\": { \"max-size\": \"20m\", \"max-file\": \"2\" }}' > /etc/docker/daemon.json && systemctl restart docker"
eks_ami_id        = "ami-0c5b63ec54dd3fc38"
eks_instance_type = "m5.2xlarge"

################################################################################
# Provided from "terragunt output" in infra module
################################################################################
private_subnets   = [
    "subnet-03dd976d2838e9f37",
    "subnet-0a5fd42ce0ea1b536",
    "subnet-03b9673aaed3a98d1",
    "subnet-0f78aa80d5b3d0fe2"
]
public_subnets    = [
    "subnet-0bba164d63e82cbce",
    "subnet-0e4c7d045d32cb946",
    "subnet-0b749fe76b478ad23",
    "subnet-0d028225735843b13"
]
vpc_id            = "vpc-05ddd99caff0c3e9d"

################################################################################
# Tags
################################################################################
tags = {
    "terraform" = "true"
    "env" = "dev"
}
