##################################################################################
# AWS Provider CONFIGURATIONS
##################################################################################
variable "region" {
  description = "Region to deploy in"
}

variable "account_role" {
  description = "AWS account number"
}

variable "vpc_name" {
  description = "Name of vpc deployed in"
}

variable "app_name" {
  description = "Name of application"
}

variable "remote_state_path" {
  description = "path of the remote state key"
}

##################################################################################
# EC2 CONFIGURATIONS
##################################################################################

variable "instance_type" {
  description = "Type of EC2 Instance"
}

variable "instance_number" {
  description = "Type of EC2 Instance"
}

variable "key_name" {
  description = "AWS Keypair"
}

variable "ami" {
  description = "AWS AMI to be used"
}


variable "ec2_subnet_id" {
  description = "subnet the ec2 will live in"
}

##################################################################################
# ALB CONFIGURATIONS
##################################################################################
variable "is_internal" {
  description = "Does the alb need to be internet facing"
}

variable "alb_subnets" {
  description = "IPs to open for alb access."
  type = "list"
  default = []
}

variable "app_port" {
  description = "port number for the application"
}

variable "alb_bucket_logs" {
  description = "Location of s3 bucket to store alb logs"
}


##################################################################################
# TAGS
##################################################################################
variable "tag_env" {
  description = "Environment"
}

variable "tag_component" {
  description = "purpose of ec2 instance"
}
