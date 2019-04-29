##################################################################################
# EC2 CONFIGURATIONS
##################################################################################
variable "instance_number" {
  description = "Number of EC2 Instances"
}

variable "instance_type" {
  description = "Type of EC2 Instance"
}

variable "key_name" {
  description = "AWS Keypair"
}

variable "ami" {
  description = "AWS AMI to be used"
}

variable "instance-sg" {
  description = "Security group to attach to server"
  type = "list"
  default = []
}

variable "subnet_ids" {
  description = "Subnet the ec2 will live in"
}

variable "hostname" {
  description = "ec2 instance hostname to be set"
}

variable "hosts_file" {
  description = "used to set the /etc/hosts file"
}
##################################################################################
# TAGS
##################################################################################
variable "tag-name" {
  description = "Name of instance"
}

variable "tag-env" {
  description = "Environment"
}

variable "tag-type" {
  description = "purpose of ec2 instance"
}

variable "tag-terraform" {
  description = "Is this controlled by terraform"
}

##################################################################################
# ROUTE53 CONFIGURATIONS
##################################################################################
variable "route53_zone_id" {
  description = "ID for route53 zone to be used"
}

variable "route53_record_name" {
  description = "name for route53 record"
}
