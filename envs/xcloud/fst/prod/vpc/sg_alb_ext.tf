# Create security group that should be deployed to all instances for scanning/logs
module "alb_ext_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.1.0"

  name        = "alb_ext"
  description = "allow ports for external facing load balancer"

  tags {
    Owner = "${var.owner_tag}"
  }

  vpc_id = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "inbound https"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "unrestricted outbound"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
