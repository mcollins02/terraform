# SECURITY GROUPS #
resource "aws_security_group" "atlantis-alb-external" {
  name        = "atlantis-external-alb"
  vpc_id      = "vpc-03881cbe548cb2d4d"

  tags {
    Name = "atlantis-external-alb"
    terraform = "true"
  }

  ingress {
    from_port   = 4141
    to_port     = 4141
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
