terragrunt = {
  terraform {
    source = "git::ssh://git@bitbucket.org/sensusanalytics-dev/xylem-aws-terraform.git//templates//application-example//application-mod"
  }
  include = {
    path = "${find_in_parent_folders()}"
  }
}

################################################################################
# Environment Definition
################################################################################
account_role               = "arn:aws:iam::057203926908:role/FullAdmin" #set this to the role of the account you'll be deploying to. ex: arn:aws:iam::ACCOUNTNUMBER:role/FullAdmin
region                     = "us-east-1" #set this to the aws region you'll be deploying to. ex: us-east-1
vpc_name                   = "dev-owa" #set this to whatever the name of the environment to be deployed. ex: owa-dev
app_name                   = "priority" #set this to the name of the application being deployed
remote_state_path          = "envs/xcloud/owa/dev/infra/terraform.tfstate" #set to complete path of the remote state key

################################################################################
# EC2 Configurations
################################################################################
instance_type              = "t2.medium" #Set the instance type to be deployed for the ansible server. ex: t2.medium
instance_number            = "2" #set the total number of instances to be deployed
ami                        = "ami-0da72d722484b968f" #set the appropriate ami to use for the jenkins instance. ex: ami-02eac2c0129f6376b
key_name                   = "owa-devops-dev" #set the aws key name to be used for SSH access. ex: owa-devops-dev
ec2_subnet_id              = "subnet-0bba164d63e82cbce" #set to the proper public or private subnet to deploy to ex: subnet-026fc96a629c54210

################################################################################
# ALB Configurations
################################################################################
is_internal                = true #set to false if deploying external load balancer, true to deploy internal load balancer
app_port                   = "8080" #set to the port that the application listens on ex: 8080
alb_bucket_logs            = "057203926908-dev-owa-alb-logs" #location of the S3 bucket that will store the application load balancer logs
alb_subnets                = ["subnet-0bba164d63e82cbce", "subnet-0e4c7d045d32cb946", "subnet-0b749fe76b478ad23", "subnet-0d028225735843b13"] #set to the public or private subnets to attached to the alb

################################################################################
# Tags
################################################################################
tag_env                    = "dev" #environment this is being deployed in, ex: dev
tag_component              = "priority" #the purpose or type of ec2 instance
