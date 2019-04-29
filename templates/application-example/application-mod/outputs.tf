output "application_instance_id" {
    value = "${module.ec2_cluster.id}"
}

output "application_private_ip" {
    value = "${module.ec2_cluster.private_ip}"
}

output "application_alb_dns" {
    value = "${module.alb.dns_name}"
}

output "route_53_a_records" {
    value = "${aws_route53_record.application_route53_a_record.*.fqdn}"
}

output "alb_cname_public" {
    value = "${aws_route53_record.alb_cname_public.*.fqdn}"
}

output "alb_cname_private" {
    value = "${aws_route53_record.alb_cname_private.*.fqdn}"
}
