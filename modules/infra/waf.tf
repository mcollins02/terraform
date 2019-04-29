################################################################################
# Deploy WAF from CloudFormation
################################################################################
resource "aws_cloudformation_stack" "this" {
  count             = "${var.waf_enabled ? 1 : 0}"
  name              = "awswafsecurityautomations"

  parameters {
    AccessLogBucket = "${data.aws_caller_identity.current.account_id}-${var.vpc_name}-alb-logs"
  }

  capabilities      = ["CAPABILITY_IAM"]
  template_url      = "https://s3.amazonaws.com/aws-waf-template/aws-waf-security-automations-alb.template"
  depends_on        = ["aws_s3_bucket.alb_logs"]

}