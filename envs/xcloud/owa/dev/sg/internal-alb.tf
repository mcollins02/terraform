resource "aws_security_group" "xcloud_dev_owa_alb-internal" {
  name        = "dev-owa-alb-internal"
  vpc_id      = "${var.dev-owa-vpc}"

  tags {
    Name = "dev-owa-alb-internal"
    terraform = "true"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = ["${var.dev-owa-ovpn-sg}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
