################################################################################
# Security group for external alb
################################################################################
module "alb_ext_sg" {
  source                   = "terraform-aws-modules/security-group/aws"
  version                  = "2.1.0"

  name                     = "alb_ext"
  description              = "allow ports for external facing load balancer"

  tags {
    terraform = "true"
  }

  vpc_id                   = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port            = 443
      to_port              = 443
      protocol             = "tcp"
      description          = "inbound https"
      cidr_blocks          = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks  = [
    {
      from_port            = 0
      to_port              = 0
      protocol             = -1
      description          = "unrestricted outbound"
      cidr_blocks          = "0.0.0.0/0"
    },
  ]
}

################################################################################
# Security group for OpenVPN
################################################################################
resource "aws_security_group" "ovpn" {
  name        = "openvpn"
  vpc_id      = "${module.vpc.vpc_id}"

  tags {
    terraform = "true"
  }

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 943
    to_port     = 1194
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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



################################################################################
# Security group for Jenkins ALB
################################################################################
resource "aws_security_group" "alb-jenkins" {
  name        = "alb-jenkins"
  vpc_id      = "${module.vpc.vpc_id}"

  tags {
    Name = "${module.vpc.vpc_id}-alb-jenkins"
    terraform = "true"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = ["${aws_security_group.ovpn.id}"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["172.29.10.0/24","172.25.0.0/16","172.21.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################################################################
# Security group for scanning/logs to secops VPC
################################################################################
module "secops_sg" {
  source                   = "terraform-aws-modules/security-group/aws"
  version                  = "2.1.0"

  name                     = "secops"
  description              = "allow ports for scanning and log delivery"

  tags                     = "${var.tags}"

  vpc_id                   = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port            = 0
      to_port              = 0
      protocol             = -1
      description          = "nessus scanning"
      cidr_blocks          = "10.2.0.0/20"
    },
  ]

  egress_with_cidr_blocks  = [
    {
      from_port            = 514
      to_port              = 514
      protocol             = "udp"
      description          = "log delivery"
      cidr_blocks          = "10.2.0.0/20"
    },
  ]
}

################################################################################
# Security group Ansible/Jenkins
################################################################################
resource "aws_security_group" "ansible-control" {
  name        = "ansible-control"
  vpc_id      = "${module.vpc.vpc_id}"

  tags {
    Name = "terraform-ansible-control"
    terraform = "true"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.29.10.0/24","172.25.0.0/16","172.21.0.0/16"]
    security_groups = ["${aws_security_group.ovpn.id}","${aws_security_group.jenkins.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "jenkins" {
  name        = "jenkins"
  vpc_id      = "${module.vpc.vpc_id}"

  tags {
    Name = "terraform-jenkins"
    Terraform = "true"
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = ["${aws_security_group.alb-jenkins.id}"]
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
  vpc_id      = "${module.vpc.vpc_id}"

  tags {
    Name = "terraform-internal-ssh"
    Terraform = "true"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.ovpn.id}","${aws_security_group.ansible-control.id}"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.29.10.0/24","172.25.0.0/16","172.21.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################################################################
# Security Group for Route53 Inbound Endpoint
################################################################################
module "r53-in_sg" {
  source                   = "terraform-aws-modules/security-group/aws"
  name                     = "r53-in"
  description              = "DNS ports for inbound resolver"
  tags                     = "${var.tags}"

  vpc_id                   = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port            = 53
      to_port              = 53
      protocol             = "udp"
      description          = "outbound UDP DNS"
      cidr_blocks          = "0.0.0.0/0"
    },
    {
      from_port            = 53
      to_port              = 53
      protocol             = "tcp"
      description          = "outbound TCP DNS"
      cidr_blocks          = "0.0.0.0/0"
    },
  ]
}
