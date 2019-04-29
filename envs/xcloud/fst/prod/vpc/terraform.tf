provider "aws" {
  profile = "xylem-admin"
  region = "${var.region}"
  assume_role = {
   role_arn = "${var.fst-prod_role}"
  }
}

terraform {
  backend "s3" {
    profile = "xylem-admin"
    bucket = "xcloud-terraformstate"
    key    = "fst/prod"
    dynamodb_table = "terraform_locks"
    region = "us-east-1"
  }
}