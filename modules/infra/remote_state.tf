data "terraform_remote_state" "xylem-network" {
  backend  = "s3"
    config {
      bucket         = "xylem-terraformstate"
      key            = "envs/xylem-network/${var.region}/terraform.tfstate"
      region         = "us-east-1"
    }
  }