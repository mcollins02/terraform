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
