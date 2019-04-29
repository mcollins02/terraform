################################################################################
# Remote State Data
################################################################################

# data "terraform_remote_state" "vpc" {
#   backend            = "s3"
#   config {
#     bucket           = "xylem-terraformstate"
#       key            = "${var.remote_state_path}"
#       dynamodb_table = "terraform_locks"
#     region           = "us-east-1"
#   }
# }

data "terraform_remote_state" "vpc" {
  backend            = "s3"
  config {
    bucket           = "terraform-mikec-sand"
      key            = "${var.remote_state_path}"
      dynamodb_table = "DynamoDBLock"
    region           = "us-east-1"
  }
}
