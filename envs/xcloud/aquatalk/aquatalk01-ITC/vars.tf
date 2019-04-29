# Using local AWS profiles on workstation for authentication
# Need some sort of pipeline for this (Jenkins?)
variable "profile" {
  default = "xylem-admin"
}
variable "itc_role" {
  default = "arn:aws:iam::674535337008:role/FullAdmin"
}


variable "region" {
  default = "us-east-1"
}

#
# Assign VPC name, DNS and IP info 
#
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  default = "aquatalk01"
}

variable "available_azs" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "domain_name" {
  default = "aquatalk01.cloud-xylem.net"
}

variable "priv_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "pub_subnets" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "db_subnets" {
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "dns_server" {
  default = "10.0.0.2"
}

#
# Other
#

variable "secops_vpc_id" {
  default = "vpc-0000b9c8f006864bf"
}

variable "secops_cidr" {
  default = "10.2.0.0/20"
}

variable "saas_cidr" {
  default = "162.255.236.0/22"
}

variable "load_balancer_name" {
  description = "The resource name and Name tag of the load balancer."
  default     = "applb-1834y6dgs"
}

#
# Tags
#

variable "tags" {
  description = "A map of tags to add to all resources"

  default = {
    owner_tag    = "terraform"
    customer_tag = "aquatalk01"
  }
}

variable "owner_tag" {
  default = "terraform"
}

variable "customer_tag" {
  default = "aquatalk01"
}
