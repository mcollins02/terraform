# Using local AWS profiles on workstation for authentication
# Need some sort of pipeline for this (Jenkins?)
variable "profile" {
  default = "xylem-admin"
}
variable "fst-prod_role" {
  default = "arn:aws:iam::589756021628:role/FullAdmin"
}

variable "region" {
  default = "us-east-1"
}

#
# Assign VPC name, DNS and IP info 
#
variable "vpc_cidr" {
  default = "10.250.0.0/16"
}

variable "vpc_name" {
  default = "prod-fst"
}

variable "available_azs" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}

variable "domain_name" {
  default = "prod-fst.xylem-cloud.com"
}

variable "priv_subnets" {
  default = ["10.250.1.0/24", "10.250.2.0/24", "10.250.3.0/24", "10.250.4.0/24"]
}

variable "pub_subnets" {
  default = ["10.250.11.0/24", "10.250.12.0/24", "10.250.13.0/24", "10.250.14.0/24"]
}

variable "db_subnets" {
  default = ["10.250.21.0/24", "10.250.22.0/24", "10.250.23.0/24", "10.250.24.0/24"]
}

variable "dns_server" {
  default = "10.250.0.2"
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

variable "owner_tag" {
  default = "Terraform"
}

variable "customer_tag" {
  default = "prod-fst"
}
