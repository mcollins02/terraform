terraform {
  backend "s3" {}
}

# SECURITY GROUPS #
resource "aws_security_group" "ansible-control" {
  name        = "ansible-control"
  vpc_id      = "${var.dev-owa-vpc}"

  tags {
    Name = "terraform-ansible-control"
    terraform = "true"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${var.dev-owa-ovpn-sg}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "internal-ssh" {
  name        = "internal-ssh"
  vpc_id      = "${var.dev-owa-vpc}"

  tags {
    Name = "terraform-internal-ssh"
    Terraform = "true"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${var.dev-owa-ovpn-sg}","${aws_security_group.ansible-control.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
