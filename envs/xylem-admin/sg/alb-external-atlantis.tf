# SECURITY GROUPS #
resource "aws_security_group" "xylem_admin_alb_atlantis" {
  name        = "xylem-admin-atlantis-alb"
  vpc_id      = "vpc-03881cbe548cb2d4d"

  tags {
    Name = "xylem-admin-atlantis-alb"
    terraform = "true"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["18.205.93.0/25", "18.234.32.128/25", "13.52.5.0/25"]
  }

  ingress {
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  security_groups = [""] #NEED TO UPDATE WITH OVPN SECURITY GROUP
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
