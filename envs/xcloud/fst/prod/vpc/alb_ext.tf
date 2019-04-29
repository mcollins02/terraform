data "aws_caller_identity" "current" {}

resource "aws_lb" "external" {
  load_balancer_type = "application"
  name               = "${var.vpc_name}-alb"
  subnets            = ["${module.vpc.public_subnets}"]
  security_groups    = ["${module.alb_ext_sg.this_security_group_id}"]
  tags = {
    Owner    = "${var.owner_tag}"    
  }
  access_logs {
    enabled = true
    bucket  = "${data.aws_caller_identity.current.account_id}-${var.vpc_name}-alb-logs"
  }
  depends_on = ["aws_s3_bucket.alb_logs"]
}

resource "aws_s3_bucket" "alb_logs" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.vpc_name}-alb-logs"
  acl    = "private"
  force_destroy = true
}
resource "aws_s3_bucket_policy" "logs" {
  bucket = "${aws_s3_bucket.alb_logs.id}"
  policy =<<POLICY
{
    "Version": "2012-10-17",
    "Id": "${var.vpc_name}-policy",
    "Statement": [
        {
            "Sid": "${var.vpc_name}-id",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::127311923021:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${data.aws_caller_identity.current.account_id}-${var.vpc_name}-alb-logs/*"
        }
    ]
}
POLICY
}