################################################################################
# Security group for Application ALB
################################################################################
resource "aws_security_group" "alb_sg" {
  name        = "${var.app_name}-alb-sg"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  tags {
    Name = "${var.app_name}-alb-sg"
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
    security_groups = ["${data.terraform_remote_state.vpc.ovpn_sg_id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################################################################
# Application Security group for EC2
################################################################################
resource "aws_security_group" "application_sg" {
  name        = "${var.app_name}-sg"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  tags {
    Name = "${var.app_name}-sg"
    terraform = "true"
  }

  ingress {
    from_port   = "${var.app_port}"
    to_port     = "${var.app_port}"
    protocol    = "tcp"
    security_groups = ["${aws_security_group.alb_sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
