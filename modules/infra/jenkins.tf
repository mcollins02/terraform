resource "aws_instance" "jenkins" {
  count                  = "${var.jenkins_enable ? 1 : 0}"
  ami                    = "${var.jenkins_ami}"
  instance_type          = "t2.medium"
  subnet_id              = "${module.vpc.private_subnets[0]}"
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}","${aws_security_group.internal-ssh.id}"]
  key_name               = "${var.key_name}"

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname --static "${var.vpc_name}-jenkins"
              echo "127.0.0.1 localhost.localdomain localhost4 localhost4.localdomain4 ${var.vpc_name}-jenkins jenkins${var.dns_domain} localhost" > hosts
              echo "::1 localhost localhost.localdomain localhost6 localhost6.localdomain6" >> hosts
              EOF

  tags {
    Name                 = "${var.vpc_name}-jenkins"
    env                  = "${lookup(var.tags, "env")}"
    component            = "jenkins"
    terraform            = "true"
  }

}

resource "aws_route53_record" "route53_a_record_jenkins" {
  count   = "${var.jenkins_enable ? 1 : 0}"
  zone_id = "${aws_route53_zone.private.zone_id}"
  name    = "jenkins-1.${var.dns_domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.jenkins.private_ip}"]
}
