
# Create security group that should be deployed to all instances for scanning/logs
module "secops_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.1.0"

  name        = "secops"
  description = "allow ports for scanning and log delivery"

  vpc_id = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "nessus scanning"
      cidr_blocks = "${var.secops_cidr}"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 514
      to_port     = 514
      protocol    = "udp"
      description = "log delivery"
      cidr_blocks = "${var.secops_cidr}"
    },
  ]
}
