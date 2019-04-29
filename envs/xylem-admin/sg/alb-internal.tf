terraform {
  backend "s3" {}
}

resource "aws_security_group" "atlantis-alb-internal" {
  name        = "atlantis-alb-internal"
  vpc_id      = "vpc-03881cbe548cb2d4d"

  tags {
    Name = "atlantis-alb-internal"
    terraform = "true"
  }

  ingress {
    from_port   = 4141
    to_port     = 4141
    protocol    = "tcp"
    security_groups = [""] #needs vpn security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
