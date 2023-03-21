data "aws_iam_policy_document" "external_dns_iam_policy_document" {
  statement {
    effect    = "Allow"
    resources = distinct(var.route53_zone_arns)
    actions   = ["route53:ChangeResourceRecordSets"]
  }

  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
    ]
  }
}
