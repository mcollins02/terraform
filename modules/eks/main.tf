terraform {
  backend "s3" {}
}

provider "aws" {
  profile = "xylem-admin"
  region = "${var.region}"
  assume_role = {
   role_arn = "${var.account_role}"
  }
}

################################################################################
# Deploy EKS Cluster
################################################################################
module "eks" {
  source                                       = "terraform-aws-modules/eks/aws"
  cluster_name                                 = "${var.eks_cluster_name}"
  subnets                                      = "${concat(var.private_subnets,var.public_subnets)}"
  tags                                         = "${var.tags}"
  vpc_id                                       = "${var.vpc_id}"
  worker_groups                                = "${local.worker_groups}"
  worker_group_count                           = "1"
  map_roles_count                              = "1"
  map_roles                                    = [
    {
      role_arn                                 = "${var.account_role}"
      username                                 = "FullAdmin"
      group                                    = "system:masters"
    },
  ]
  kubeconfig_aws_authenticator_additional_args = ["-r", "${var.account_role}"]
  cluster_create_timeout                       = "45m"
  cluster_delete_timeout                       = "45m"
}
locals {
  worker_groups = [
    {
      name                 = "worker" # Name of the worker group. Literal count.index will never be used but if name is not set, the count.index interpolation will be used.
      ami_id               = "${var.eks_ami_id}" # AMI ID for the eks workers. If none is provided, Terraform will search for the latest version of their EKS optimized worker AMI.
      asg_desired_capacity = "3"           # Desired worker capacity in the autoscaling group.
      asg_max_size         = "6"           # Maximum worker capacity in the autoscaling group.
      asg_min_size         = "3"           # Minimum worker capacity in the autoscaling group.
      instance_type        = "${var.eks_instance_type}"    # Size of the workers instances.
      spot_price           = ""            # Cost of spot instance.
      root_volume_size     = "500"          # root volume size of workers instances.
      root_volume_type     = "gp2"         # root volume type of workers instances, can be 'standard', 'gp2', or 'io1'
      root_iops            = "0"           # The amount of provisioned IOPS. This must be set with a volume_type of "io1".
      key_name             = "${var.eks_key_name}"  # The key name that should be used for the instances in the autoscaling group
      pre_userdata         = "${var.eks_pre_userdata}" #userdata to pre-append to the default userdata.
      additional_userdata  = ""            # userdata to append to the default userdata.
      ebs_optimized        = true          # sets whether to use ebs optimization on supported types.
      public_ip            = false         # Associate a public ip address with a worker
      kubelet_node_labels  = ""            # This string is passed directly to kubelet via --node-lables= if set. It should be comma delimited with no spaces. If left empty no --node-labels switch is added.
      subnets              = "${join(",", var.private_subnets)}"
    }
  ]
}