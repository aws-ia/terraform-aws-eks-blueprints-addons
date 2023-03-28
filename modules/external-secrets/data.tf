data "aws_iam_policy_document" "external_secrets" {
  statement {
    actions = ["ssm:GetParameter"]
    resources = var.external_secrets_ssm_parameter_arns
  }

  statement {
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds",
    ]
    resources = var.external_secrets_secrets_manager_arns
  }

  statement {
    # it seems `ssm:DescribeParameters` needs wildcard on resources.
    actions   = ["ssm:DescribeParameters"]
    resources = ["arn:${var.addon_context.aws_partition_id}:ssm:${var.addon_context.aws_region_name}:${var.addon_context.aws_caller_identity_account_id}:*"]
  }

  statement {
    # it seems `secretsmanager:ListSecrets` needs wildcard on resources.
    actions   = ["secretsmanager:ListSecrets"]
    resources = ["arn:${var.addon_context.aws_partition_id}:secretsmanager:${var.addon_context.aws_region_name}:${var.addon_context.aws_caller_identity_account_id}:secret:*"]
  }
}
