resource "aws_s3_bucket" "kops_bucket" {
  bucket = "prod-ca-kops"
  acl    = "private"

  tags = {
    Name        = "Kops Store"
    Environment = "Prod"
    Project     = "SA"
  }

  versioning {
    enabled = true
  }  
}