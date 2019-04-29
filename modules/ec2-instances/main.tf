terraform {
  backend "s3" {}
}

##################################################################################
# RESOURCES
##################################################################################

#Creates EC2 Instance#
resource "aws_instance" "instance" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  count                  = "${var.instance_number}"
  subnet_id              = "${var.subnet_ids}"
  vpc_security_group_ids = ["${var.instance-sg}"]
  key_name               = "${var.key_name}"

  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname --static "${var.hostname}"
              echo "127.0.0.1 localhost.localdomain localhost4 localhost4.localdomain4 ${var.hosts_file} localhost" > hosts
              echo "::1 localhost localhost.localdomain localhost6 localhost6.localdomain6" >> hosts
              EOF

  tags {
    Name                 = "${var.tag-name}"
    env                  = "${var.tag-env}"
    type                 = "${var.tag-type}"
    terraform            = "${var.tag-terraform}"
  }

}

resource "aws_route53_record" "route53_a_record" {
  zone_id = "${var.route53_zone_id}"
  name    = "${var.route53_record_name}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.instance.private_ip}"]
}
