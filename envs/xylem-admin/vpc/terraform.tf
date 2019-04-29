provider "aws" {
  profile = "xylem-admin"
  region = "us-east-1"
}

terraform {
  backend "s3" {
    profile = "xylem-admin"
    bucket = "xcloud-terraformstate"
    key    = "xylem-admin/vpc"
    dynamodb_table = "terraform_locks"
    region = "us-east-1"
  }
}