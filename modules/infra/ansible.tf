resource "aws_instance" "ansible-control" {
  count                  = "${var.ansible-control_enable ? 1 : 0}"
  ami                    = "${var.ansible-control_ami}"
  instance_type          = "t2.medium"
  subnet_id              = "${module.vpc.private_subnets[0]}"
  vpc_security_group_ids = ["${aws_security_group.ansible-control.id}"]
  key_name               = "${var.key_name}"

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname --static "${var.vpc_name}-ansible-control"
              echo "127.0.0.1 localhost.localdomain localhost4 localhost4.localdomain4 ${var.vpc_name}-ansible-control ansible-control${var.dns_domain} localhost" > hosts
              echo "::1 localhost localhost.localdomain localhost6 localhost6.localdomain6" >> hosts
              EOF

  tags {
    Name                 = "${var.vpc_name}-ansible-control"
    env                  = "${lookup(var.tags, "env")}"
    component            = "ansible-control-machine"
    terraform            = "true"
  }

}

resource "aws_route53_record" "route53_a_record_ansible-control" {
  count                  = "${var.ansible-control_enable ? 1 : 0}"
  zone_id = "${aws_route53_zone.private.zone_id}"
  name    = "ansible-control-1.${var.dns_domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.ansible-control.private_ip}"]
}

################################################################################
# Ansible IAM vars
################################################################################
resource "aws_iam_user" "ansible_powerUser" {
  count                  = "${var.ansible-control_enable ? 1 : 0}"
  name = "ansible_powerUser"
  force_destroy = true
}
resource "aws_iam_group" "ansible_group" {
  count                  = "${var.ansible-control_enable ? 1 : 0}"
  name = "ansible_group"
}
resource "aws_iam_group_policy_attachment" "ansible_policy" {
  count                  = "${var.ansible-control_enable ? 1 : 0}"
  group      = "ansible_group"
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
  depends_on = ["aws_iam_group.ansible_group"]
}
resource "aws_iam_group_membership" "ansible" {
  count                  = "${var.ansible-control_enable ? 1 : 0}"
  name = "ansible-group-membership"
  users = [
    "${aws_iam_user.ansible_powerUser.name}"
  ]
  group = "${aws_iam_group.ansible_group.name}"
}
