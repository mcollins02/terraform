################################################################################
# Deploy External ALB & S3 bucket for access logs
################################################################################
data "aws_caller_identity" "current" {}

resource "aws_lb" "external" {
  count             = "${var.waf_enabled ? 1 : 0}"
  load_balancer_type = "application"
  name               = "${var.vpc_name}-alb"
  subnets            = ["${module.vpc.public_subnets}"]
  security_groups    = ["${module.alb_ext_sg.this_security_group_id}"]
  tags               = "${var.tags}"
  access_logs {
    enabled          = true
    bucket           = "${data.aws_caller_identity.current.account_id}-${var.vpc_name}-alb-logs"
  }
  depends_on         = ["aws_s3_bucket.alb_logs"]
}
resource "aws_s3_bucket" "alb_logs" {
  count             = "${var.waf_enabled ? 1 : 0}"
  bucket             = "${data.aws_caller_identity.current.account_id}-${var.vpc_name}-alb-logs"
  acl                = "private"
  force_destroy      = true
}
resource "aws_s3_bucket_policy" "logs" {
  count             = "${var.waf_enabled ? 1 : 0}"
  bucket             = "${aws_s3_bucket.alb_logs.id}"
  policy             =<<POLICY
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

################################################################################
# Deploy Internal ALB for Jenkins
################################################################################
resource "aws_alb" "alb_jenkins_internal" {
  count                       = "${var.jenkins_enable ? 1 : 0}"
	name		                    =	"${var.vpc_name}-alb-jenkins"
	internal	                  =	true
	security_groups							=	["${aws_security_group.alb-jenkins.id}"]
	subnets											=	["${module.vpc.private_subnets}"]
	enable_deletion_protection	=	false

  tags                        = "${var.tags}"
}

resource "aws_alb_listener" "alb_listener_jenkins" {
  count             = "${var.jenkins_enable ? 1 : 0}"
  load_balancer_arn = "${aws_alb.alb_jenkins_internal.id}"
  port 						  = "443"
  protocol 				  = "HTTPS"
  ssl_policy 			  = "${var.ssl_security_policy}"
  certificate_arn 	= "${aws_acm_certificate.acm_certificate.id}"
  default_action {
  target_group_arn  = "${aws_alb_target_group.alb_target_group_jenkins.id}"
  type = "forward"
  }
}

resource "aws_alb_target_group" "alb_target_group_jenkins" {
  count     = "${var.jenkins_enable ? 1 : 0}"
	name			= "${var.vpc_name}-jenkins-int"
	vpc_id		= "${module.vpc.vpc_id}"
	port			= "8080"
	protocol	= "HTTP"
	health_check {
                path 								= "/login"
                port 								= "8080"
                protocol 						= "HTTP"
                healthy_threshold 	= 5
                unhealthy_threshold = 2
                interval 						= 30
                timeout 						= 5
                matcher 						= "200"
        }
}

resource "aws_alb_target_group_attachment" "alb_target_group_attach_jenkins" {
  count            = "${var.jenkins_enable ? 1 : 0}"
  target_group_arn = "${aws_alb_target_group.alb_target_group_jenkins.arn}"
  target_id        = "${aws_instance.jenkins.id}"
  port             = "8080"
}