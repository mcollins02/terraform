data "template_file" "init" {
  template = "${file("${path.module}/user_data.sh")}"
  vars {
    domain_name = "${var.domain_name}"
  }
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"

  name                   = "${var.vpc_name}-${var.app_name}"
  instance_count         = "${var.instance_number}"
  use_num_suffix         = true
  associate_public_ip_address = true
  user_data              = "${data.template_file.init.rendered}"
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.application_sg.id}","${data.terraform_remote_state.vpc.internal_ssh_id}"]
  subnet_id              = "${var.ec2_subnet_id}"

  tags = {
    terraform = "true"
    env       = "${var.tag_env}"
    type      = "${var.tag_component}"
  }
}
