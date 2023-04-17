locals {
  namespace = try(coalesce(var.namespace, "default")) # Need to explicitly set default for use with IRSA
}

################################################################################
# Helm Release
################################################################################

resource "helm_release" "this" {
  count = var.create && var.create_release ? 1 : 0

  name             = try(coalesce(var.name, var.chart), "")
  description      = var.description
  namespace        = local.namespace
  create_namespace = var.create_namespace
  chart            = var.chart
  version          = var.chart_version # conflicts with reserved keyword
  repository       = var.repository
  values           = var.values

  timeout                    = var.timeout
  repository_key_file        = var.repository_key_file
  repository_cert_file       = var.repository_cert_file
  repository_ca_file         = var.repository_ca_file
  repository_username        = var.repository_username
  repository_password        = var.repository_password
  devel                      = var.devel
  verify                     = var.verify
  keyring                    = var.keyring
  disable_webhooks           = var.disable_webhooks
  reuse_values               = var.reuse_values
  reset_values               = var.reset_values
  force_update               = var.force_update
  recreate_pods              = var.recreate_pods
  cleanup_on_fail            = var.cleanup_on_fail
  max_history                = var.max_history
  atomic                     = var.atomic
  skip_crds                  = var.skip_crds
  render_subchart_notes      = var.render_subchart_notes
  disable_openapi_validation = var.disable_openapi_validation
  wait                       = var.wait
  wait_for_jobs              = var.wait_for_jobs
  dependency_update          = var.dependency_update
  replace                    = var.replace
  lint                       = var.lint

  dynamic "postrender" {
    for_each = length(var.postrender) > 0 ? [var.postrender] : []

    content {
      binary_path = postrender.value.binary_path
      args        = try(postrender.value.args, null)
    }
  }

  dynamic "set" {
    for_each = var.set

    content {
      name  = set.value.name
      value = set.value.value
      type  = try(set.value.type, null)
    }
  }

  dynamic "set" {
    for_each = { for k, v in toset(var.set_irsa_names) : k => v if var.create && var.create_role }
    iterator = each
    content {
      name  = each.value
      value = aws_iam_role.this[0].arn
    }
  }

  dynamic "set_sensitive" {
    for_each = var.set_sensitive

    content {
      name  = set_sensitive.value.name
      value = set_sensitive.value.value
      type  = try(set_sensitive.value.type, null)
    }
  }
}

################################################################################
# IAM Role for Service Account(s) (IRSA)
################################################################################

data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

locals {
  create_role = var.create && var.create_role

  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition

  role_name           = try(coalesce(var.role_name, var.name), "")
  role_name_condition = var.role_name_use_prefix ? "${local.role_name}-*" : local.role_name
}

data "aws_iam_policy_document" "assume" {
  count = local.create_role ? 1 : 0

  dynamic "statement" {
    # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
    for_each = var.allow_self_assume_role ? [1] : []

    content {
      sid     = "ExplicitSelfRoleAssumption"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = ["arn:${local.partition}:iam::${local.account_id}:role${var.role_path}${local.role_name_condition}"]
      }
    }
  }

  dynamic "statement" {
    for_each = var.oidc_providers

    content {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = [statement.value.provider_arn]
      }

      condition {
        test     = var.assume_role_condition_test
        variable = "${replace(statement.value.provider_arn, "/^(.*provider/)/", "")}:sub"
        values   = ["system:serviceaccount:${try(statement.value.namespace, local.namespace)}:${statement.value.service_account}"]
      }

      # https://aws.amazon.com/premiumsupport/knowledge-center/eks-troubleshoot-oidc-and-irsa/?nc1=h_ls
      condition {
        test     = var.assume_role_condition_test
        variable = "${replace(statement.value.provider_arn, "/^(.*provider/)/", "")}:aud"
        values   = ["sts.amazonaws.com"]
      }
    }
  }
}

resource "aws_iam_role" "this" {
  count = local.create_role ? 1 : 0

  name        = var.role_name_use_prefix ? null : local.role_name
  name_prefix = var.role_name_use_prefix ? "${local.role_name}-" : null
  path        = var.role_path
  description = var.role_description

  assume_role_policy    = data.aws_iam_policy_document.assume[0].json
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.role_permissions_boundary_arn
  force_detach_policies = true

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "additional" {
  for_each = { for k, v in var.role_policies : k => v if local.create_role }

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}

################################################################################
# IAM Policy
################################################################################

locals {
  create_policy = local.create_role && var.create_policy

  policy_name = coalesce(var.policy_name, local.role_name)
}

data "aws_iam_policy_document" "this" {
  count = local.create_policy ? 1 : 0

  source_policy_documents   = var.source_policy_documents
  override_policy_documents = var.override_policy_documents

  dynamic "statement" {
    for_each = var.policy_statements

    content {
      sid           = try(statement.value.sid, null)
      actions       = try(statement.value.actions, null)
      not_actions   = try(statement.value.not_actions, null)
      effect        = try(statement.value.effect, null)
      resources     = try(statement.value.resources, null)
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}

resource "aws_iam_policy" "this" {
  count = local.create_policy ? 1 : 0

  name        = var.policy_name_use_prefix ? null : local.policy_name
  name_prefix = var.policy_name_use_prefix ? "${local.policy_name}-" : null
  path        = coalesce(var.policy_path, var.role_path)
  description = try(coalesce(var.policy_description, var.role_description), null)
  policy      = data.aws_iam_policy_document.this[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  count = local.create_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.this[0].arn
}
