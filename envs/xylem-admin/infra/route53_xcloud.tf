# Create subdomain private zone
resource "aws_route53_zone" "private" {
  name = "${var.dns-domain}"
  vpc {
    vpc_id = "${module.vpc.vpc_id}"
  }
}
# Create subdomain public zone
resource "aws_route53_zone" "public" {
  name = "${var.dns-domain}"
}
# Create provider for account that owns the primary domain
provider "aws" {
  alias = "primary-domain-account"
  profile = "xylem-admin"
  region = "us-east-1"
  assume_role = {
   role_arn = "arn:aws:iam::678049594014:role/FullAdmin"
  }
}
# Create subdomain "NS" records in primary domain account
resource "aws_route53_record" "subdomain" {
  provider = "aws.primary-domain-account"
  zone_id = "Z23TC4F01OEVE"
  name    = "${var.dns-domain}"
  type    = "NS"
  ttl     = "30"

  records = [
    "${aws_route53_zone.public.name_servers.0}",
    "${aws_route53_zone.public.name_servers.1}",
    "${aws_route53_zone.public.name_servers.2}",
    "${aws_route53_zone.public.name_servers.3}",
  ]
}