# Outputs #
output "xcloud-dev-owa-ansible-control" {
  description = "ansible-control security group"
  value       = "${aws_security_group.ansible-control.id}"
}

output "xcloud-dev-owa-internal-ssh" {
  description = "internal ssh security group"
  value       = "${aws_security_group.internal-ssh.id}"
}

output "xcloud-dev-owa-alb-internal" {
  description = "internal alb security group"
  value       = "${aws_security_group.xcloud_dev_owa_alb-internal.id}"
}
