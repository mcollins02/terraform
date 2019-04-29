################################################################################
# Hybrid Cloud networks
################################################################################
variable "hybrid_deny_cidr" {
  type    = "list"
  default = []
}
variable "hybrid_cidr" {
  type    = "list"
  default = []
}
variable "toronto_hybrid" {
  default = false
}
variable "raleigh_hybrid" {
  default = false
}
variable "boise_hybrid" {
  default = false
}

variable "account_role" {
  description = "FullAdmin role of the target account"
}

variable "region" {
  default = ""
}


variable "path_to_infra" {
  default = "i.e. /envs/xcloud/owa/dev/infra/"
}

