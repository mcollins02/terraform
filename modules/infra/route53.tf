################################################################################
# Create zones
################################################################################
resource "aws_route53_zone" "private" {
  name     = "${var.dns_domain}"
  vpc {
    vpc_id = "${module.vpc.vpc_id}"
  }
}
resource "aws_route53_zone" "public" {
  name        = "${var.dns_domain}"
}
################################################################################
# Custom subdomain mapping 
################################################################################
provider "aws" {
  alias       = "primary-domain-account"
  profile     = "xylem-admin"
  region      = "us-east-1"
  assume_role = {
   role_arn   = "${var.custom_zone_role}"
  }
}
resource "aws_route53_record" "custom_subdomain" {
  count       = "${var.custom_domain ? 1 : 0}" 
  provider    = "aws.primary-domain-account"
  zone_id     = "${var.custom_zone_id}"
  name        = "${var.dns_domain}"
  type        = "NS"
  ttl         = "30"

  records = [
    "${aws_route53_zone.public.name_servers.0}",
    "${aws_route53_zone.public.name_servers.1}",
    "${aws_route53_zone.public.name_servers.2}",
    "${aws_route53_zone.public.name_servers.3}",
  ]
}
################################################################################
# xCloud subdomain mapping 
################################################################################
provider "aws" {
  alias       = "xcloud-primary-domain-account"
  profile     = "xylem-admin"
  region      = "us-east-1"
  assume_role = {
   role_arn   = "arn:aws:iam::678049594014:role/FullAdmin"
  }
}
resource "aws_route53_record" "subdomain" {
  count       = "${var.custom_domain ? 0 : 1}" 
  provider    = "aws.xcloud-primary-domain-account"
  zone_id     = "Z23TC4F01OEVE"
  name        = "${var.dns_domain}"
  type        = "NS"
  ttl         = "30"

  records = [
    "${aws_route53_zone.public.name_servers.0}",
    "${aws_route53_zone.public.name_servers.1}",
    "${aws_route53_zone.public.name_servers.2}",
    "${aws_route53_zone.public.name_servers.3}",
  ]
}
################################################################################
# Route53 Inbound Resolver
################################################################################
resource "aws_route53_resolver_endpoint" "inbound" {
  name               = "${var.vpc_name}-dns"
  direction          = "INBOUND"
  security_group_ids = ["${module.r53-in_sg.this_security_group_id}"]
  ip_address {
    subnet_id        = "${module.vpc.private_subnets[0]}"
  }
  ip_address {
    subnet_id        = "${module.vpc.private_subnets[1]}"
  }
  tags               = "${var.tags}"
}

################################################################################
# Jenkins A record
################################################################################

resource "aws_route53_record" "route53_alb_cname_jenkins" {
  count   = "${var.jenkins_enable ? 1 : 0}"
  zone_id = "${aws_route53_zone.private.zone_id}"
  name    = "jenkins"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_alb.alb_jenkins_internal.dns_name}"]
}
