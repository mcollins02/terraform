terraform {
  backend "s3" {}
}

provider "aws" {
  profile = "xylem-admin"
  region = "${var.region}"
}