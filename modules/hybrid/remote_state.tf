data "terraform_remote_state" "infra" {
  backend  = "s3"
    config {
      bucket         = "xylem-terraformstate"
      key            = "${var.path_to_infra}/terraform.tfstate"
      region         = "us-east-1"
    }
  }
data "terraform_remote_state" "xylem-network" {
  backend  = "s3"
    config {
      bucket         = "xylem-terraformstate"
      key            = "envs/xylem-network/${var.region}/terraform.tfstate"
      region         = "us-east-1"
    }
  }