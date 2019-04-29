resource "aws_cloudformation_stack" "aws_waf" {
  name = "awswafsecurityautomations"

  parameters {
    AccessLogBucket = "${data.aws_caller_identity.current.account_id}-${var.vpc_name}-alb-logs"
  }

  capabilities = ["CAPABILITY_IAM"]
  template_url = "https://s3.amazonaws.com/aws-waf-template/aws-waf-security-automations-alb.template"
}
