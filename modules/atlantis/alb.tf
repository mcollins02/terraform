################################################################################
# ALB module
################################################################################
module "alb" {
  source                        = "terraform-aws-modules/alb/aws"
  load_balancer_name            = "${var.vpc_name}-alb-${var.app_name}"
  load_balancer_is_internal     = "${var.is_internal}"
  security_groups               = ["${aws_security_group.alb_sg.id}"]
  log_bucket_name               = "${var.alb_bucket_logs}"
  subnets                       = ["${var.alb_subnets}"]
  tags                          = "${map("env", "${var.tag_env}", "terraform", "true")}"
  vpc_id                        = "${data.terraform_remote_state.vpc.vpc_id}"
  https_listeners               = "${list(map("certificate_arn", "${data.terraform_remote_state.vpc.aws_acm_certificate_arn}", "port", 443))}"
  https_listeners_count         = "1"
  target_groups                 = "${list(map("name", "${var.vpc_name}-${var.app_name}-tg", "backend_protocol", "HTTP", "backend_port", "${var.app_port}"))}"
  target_groups_count           = "1"
}


resource "aws_alb_target_group_attachment" "application_alb_target_group_attach" {
  count            = "${var.instance_number}"
  target_group_arn = "${module.alb.target_group_arns[0]}"
  target_id        = "${element(module.ec2_cluster.id, count.index)}"
  port             = "${var.app_port}"
}
