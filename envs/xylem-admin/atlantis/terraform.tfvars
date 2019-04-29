terragrunt = {
  terraform {
    source = "/Users/mcollins/Documents/Work/Jira/GDO-26/add_to_bitbucket/modules/atlantis"
  }
  include = {
    path = "${find_in_parent_folders()}"
  }
}

################################################################################
# Environment Definition
################################################################################
region                     = "us-east-1"
vpc_name                   = "admin"
app_name                   = "atlantis"
domain_name                = "xylem-mcc.com"
remote_state_path          = "envs/xcloud/owa/dev/infra/terraform.tfstate"
################################################################################
# EC2 Configurations
################################################################################
instance_type              = "t2.medium"
instance_number            = "3"
ami                        = "ami-02eac2c0129f6376b"
key_name                   = "mike-sandbox1"
ec2_subnet_id              = "subnet-0d67e64c831adcde4"
################################################################################
# ALB Configurations
################################################################################
is_internal                = false
app_port                   = "4141"
alb_bucket_logs            = "497150712349-mcc-alb-logs"
alb_subnets                = ["subnet-0d67e64c831adcde4", "subnet-05a622eda6401c17c", "subnet-0433936b81b5bb624", "subnet-074a699126f441d99"]
################################################################################
# Tags
################################################################################
tag_env                    = "prod"
tag_component              = "atlantis"
