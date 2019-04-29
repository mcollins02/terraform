################################################################################
# Environment Definition
################################################################################
variable "account_role" {
  description = "FullAdmin role of the target account"
}
variable "region" {
  description = "Target AWS region to deploy assets"
}
variable "vpc_name" {
  description = "Example: dev-owa"
}
variable "dns_domain" {
  description = "Example: dev-owa.xylem-cloud.com"
}
variable "waf_enabled" {
  description = "Deploy WAF?"
  default     = true
}
variable "custom_domain" {
  description = "DNS domain other than xylem-cloud?"
  default     = false
}
variable "custom_zone_id" {
  description = "Route53 ID of custom public hosted zone"
}
variable "custom_zone_role" {
  description = "FullAdmin Role for primary route53 domain"
}

################################################################################
# VPC vars
################################################################################
variable "vpc_cidr" {
  description = "Example: 10.40.0.0/16"
}
variable "vpc_azs" {
  description = "List of Availability Zones"
  type        = "list"
}
variable "vpc_private_subnets" {
  description = "List of private subnets (1 per AZ)"
  type        = "list"
}
variable "vpc_public_subnets" {
  description = "List of public subnets (1 per AZ)"
  type        = "list"
}
variable "vpc_dns_server" {
  description = "Local DNS server (standard is .2 of CIDR)"
  type        = "list"
}

################################################################################
# ALB vars
################################################################################
variable "ssl_security_policy" {
  description = "SSL Security policy to be used, ex: ELBSecurityPolicy-2016-08"
  default     = "ELBSecurityPolicy-2016-08"
}
variable "acm_id" {
  description = "If using a pre-existing certificate"
  default = ""
}

################################################################################
# EC2 vars
################################################################################
variable "jenkins_ami" {
  default = "ami-07e32c1eab65d0bc8"
}
variable "jenkins_enable" {
  default = true
}
variable "jenkins_ebs_az" {
  default = ""
}
variable "create_ebs_jenkins" {
  default = false
}
variable "create_ebs_jenkins_docker" {
  default = false
}
variable "ansible-control_enable" {
  default = true
}
variable "ansible-control_ami" {
  default = "ami-07e32c1eab65d0bc8"
}
variable "ansible-control_instance_type" {
  default = "t2.medium"
}
variable "key_name" {
  default = ""
}



################################################################################
# Tags
################################################################################
variable "tags" {
  description = "A map of tags to add to all resources."
  type        = "map"
  default     = {
    "terraform" = "true"
  }
}