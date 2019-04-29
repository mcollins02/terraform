################################################################################
# Environment vars
################################################################################
variable "account_role" {
  description = "FullAdmin role of target account"
}
variable "region" {
  description = "target region for deployment"
}
variable "private_subnets" {
  description = "terragrunt output"
  type = "list"
}
variable "public_subnets" {
  description = "terragrunt output"
  type = "list"
}
variable "vpc_id" {
  description = "terragrunt output"
}
################################################################################
# EKS vars
################################################################################
variable "eks_cluster_name" {
  description = "Name of the EKS cluster (i.e. owa-dev-eks-1)"
}
variable "eks_key_name" {
  description = "Name of key pari (i.e. owa-devops-dev)"
}
variable "eks_pre_userdata" {
  default = "echo '{ \"log-driver\": \"json-file\", \"log-opts\": { \"max-size\": \"20m\", \"max-file\": \"2\" }}' > /etc/docker/daemon.json && systemctl restart docker"
}
variable "eks_ami_id" {
  default = "ami-0c5b63ec54dd3fc38"
}
variable "eks_instance_type" {
  default = "m5.2xlarge"
}
variable "tags" {
  type = "map"
}
