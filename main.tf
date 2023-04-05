data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
  region     = data.aws_region.current.name
}

################################################################################
# EKS Addons
################################################################################

data "aws_eks_addon_version" "this" {
  for_each = var.eks_addons

  addon_name         = try(each.value.name, each.key)
  kubernetes_version = var.cluster_version
  most_recent        = try(each.value.most_recent, true)
}

resource "aws_eks_addon" "this" {
  for_each = var.eks_addons

  cluster_name = var.cluster_name
  addon_name   = try(each.value.name, each.key)

  addon_version            = try(each.value.addon_version, data.aws_eks_addon_version.this[each.key].version)
  configuration_values     = try(each.value.configuration_values, null)
  preserve                 = try(each.value.preserve, null)
  resolve_conflicts        = try(each.value.resolve_conflicts, "OVERWRITE")
  service_account_role_arn = try(each.value.service_account_role_arn, null)

  timeouts {
    create = try(each.value.timeouts.create, var.eks_addons_timeouts.create, null)
    update = try(each.value.timeouts.update, var.eks_addons_timeouts.update, null)
    delete = try(each.value.timeouts.delete, var.eks_addons_timeouts.delete, null)
  }

  tags = var.tags
}

################################################################################
# Argo Rollouts
################################################################################

module "argo_rollouts" {
  # source = "aws-ia/eks-blueprints-addon/aws"
  source = "./modules/eks-blueprints-addon"

  create = var.enable_argo_rollouts

  # https://github.com/argoproj/argo-helm/tree/main/charts/argo-rollouts
  name             = try(var.argo_rollouts.name, "argo-rollouts")
  description      = try(var.argo_rollouts.description, "A Helm chart for Argo Rollouts")
  namespace        = try(var.argo_rollouts.namespace, "argo-rollouts")
  create_namespace = try(var.argo_rollouts.create_namespace, true)
  chart            = "argo-rollouts"
  chart_version    = try(var.argo_rollouts.chart_version, "2.22.3")
  repository       = try(var.argo_rollouts.repository, "https://argoproj.github.io/argo-helm")
  values           = try(var.argo_rollouts.values, [])

  timeout                    = try(var.argo_rollouts.timeout, null)
  repository_key_file        = try(var.argo_rollouts.repository_key_file, null)
  repository_cert_file       = try(var.argo_rollouts.repository_cert_file, null)
  repository_ca_file         = try(var.argo_rollouts.repository_ca_file, null)
  repository_username        = try(var.argo_rollouts.repository_username, null)
  repository_password        = try(var.argo_rollouts.repository_password, null)
  devel                      = try(var.argo_rollouts.devel, null)
  verify                     = try(var.argo_rollouts.verify, null)
  keyring                    = try(var.argo_rollouts.keyring, null)
  disable_webhooks           = try(var.argo_rollouts.disable_webhooks, null)
  reuse_values               = try(var.argo_rollouts.reuse_values, null)
  reset_values               = try(var.argo_rollouts.reset_values, null)
  force_update               = try(var.argo_rollouts.force_update, null)
  recreate_pods              = try(var.argo_rollouts.recreate_pods, null)
  cleanup_on_fail            = try(var.argo_rollouts.cleanup_on_fail, null)
  max_history                = try(var.argo_rollouts.max_history, null)
  atomic                     = try(var.argo_rollouts.atomic, null)
  skip_crds                  = try(var.argo_rollouts.skip_crds, null)
  render_subchart_notes      = try(var.argo_rollouts.render_subchart_notes, null)
  disable_openapi_validation = try(var.argo_rollouts.disable_openapi_validation, null)
  wait                       = try(var.argo_rollouts.wait, null)
  wait_for_jobs              = try(var.argo_rollouts.wait_for_jobs, null)
  dependency_update          = try(var.argo_rollouts.dependency_update, null)
  replace                    = try(var.argo_rollouts.replace, null)
  lint                       = try(var.argo_rollouts.lint, null)

  postrender    = try(var.argo_rollouts.postrender, [])
  set           = try(var.argo_rollouts.set, [])
  set_sensitive = try(var.argo_rollouts.set_sensitive, [])

  tags = var.tags
}

################################################################################
# Argo Workflows
################################################################################

module "argo_workflows" {
  # source = "aws-ia/eks-blueprints-addon/aws"
  source = "./modules/eks-blueprints-addon"

  create = var.enable_argo_workflows

  # https://github.com/argoproj/argo-helm/tree/main/charts/argo-workflows
  name             = try(var.argo_workflows.name, "argo-workflows")
  description      = try(var.argo_workflows.description, "A Helm chart for Argo Workflows")
  namespace        = try(var.argo_workflows.namespace, "argo-workflows")
  create_namespace = try(var.argo_workflows.create_namespace, true)
  chart            = "argo-workflows"
  chart_version    = try(var.argo_workflows.chart_version, "2.22.13")
  repository       = try(var.argo_workflows.repository, "https://argoproj.github.io/argo-helm")
  values           = try(var.argo_workflows.values, [])

  timeout                    = try(var.argo_workflows.timeout, null)
  repository_key_file        = try(var.argo_workflows.repository_key_file, null)
  repository_cert_file       = try(var.argo_workflows.repository_cert_file, null)
  repository_ca_file         = try(var.argo_workflows.repository_ca_file, null)
  repository_username        = try(var.argo_workflows.repository_username, null)
  repository_password        = try(var.argo_workflows.repository_password, null)
  devel                      = try(var.argo_workflows.devel, null)
  verify                     = try(var.argo_workflows.verify, null)
  keyring                    = try(var.argo_workflows.keyring, null)
  disable_webhooks           = try(var.argo_workflows.disable_webhooks, null)
  reuse_values               = try(var.argo_workflows.reuse_values, null)
  reset_values               = try(var.argo_workflows.reset_values, null)
  force_update               = try(var.argo_workflows.force_update, null)
  recreate_pods              = try(var.argo_workflows.recreate_pods, null)
  cleanup_on_fail            = try(var.argo_workflows.cleanup_on_fail, null)
  max_history                = try(var.argo_workflows.max_history, null)
  atomic                     = try(var.argo_workflows.atomic, null)
  skip_crds                  = try(var.argo_workflows.skip_crds, null)
  render_subchart_notes      = try(var.argo_workflows.render_subchart_notes, null)
  disable_openapi_validation = try(var.argo_workflows.disable_openapi_validation, null)
  wait                       = try(var.argo_workflows.wait, null)
  wait_for_jobs              = try(var.argo_workflows.wait_for_jobs, null)
  dependency_update          = try(var.argo_workflows.dependency_update, null)
  replace                    = try(var.argo_workflows.replace, null)
  lint                       = try(var.argo_workflows.lint, null)

  postrender    = try(var.argo_workflows.postrender, [])
  set           = try(var.argo_workflows.set, [])
  set_sensitive = try(var.argo_workflows.set_sensitive, [])

  tags = var.tags
}

################################################################################
# Cloudwatch Metrics
################################################################################

locals {
  cloudwatch_metrics_service_account = try(var.cloudwatch_metrics.service_account_name, "aws-cloudwatch-metrics")
}

module "cloudwatch_metrics" {
  # source = "aws-ia/eks-blueprints-addon/aws"
  source = "./modules/eks-blueprints-addon"

  create = var.enable_cloudwatch_metrics

  # https://github.com/aws/eks-charts/tree/master/stable/aws-cloudwatch-metrics
  name             = try(var.cloudwatch_metrics.name, "aws-cloudwatch-metrics")
  description      = try(var.cloudwatch_metrics.description, "A Helm chart to deploy aws-cloudwatch-metrics project")
  namespace        = try(var.cloudwatch_metrics.namespace, "amazon-cloudwatch")
  create_namespace = try(var.cloudwatch_metrics.create_namespace, true)
  chart            = "aws-cloudwatch-metrics"
  chart_version    = try(var.cloudwatch_metrics.chart_version, "0.0.8")
  repository       = try(var.cloudwatch_metrics.repository, "https://aws.github.io/eks-charts")
  values           = try(var.cloudwatch_metrics.values, [])

  timeout                    = try(var.cloudwatch_metrics.timeout, null)
  repository_key_file        = try(var.cloudwatch_metrics.repository_key_file, null)
  repository_cert_file       = try(var.cloudwatch_metrics.repository_cert_file, null)
  repository_ca_file         = try(var.cloudwatch_metrics.repository_ca_file, null)
  repository_username        = try(var.cloudwatch_metrics.repository_username, null)
  repository_password        = try(var.cloudwatch_metrics.repository_password, null)
  devel                      = try(var.cloudwatch_metrics.devel, null)
  verify                     = try(var.cloudwatch_metrics.verify, null)
  keyring                    = try(var.cloudwatch_metrics.keyring, null)
  disable_webhooks           = try(var.cloudwatch_metrics.disable_webhooks, null)
  reuse_values               = try(var.cloudwatch_metrics.reuse_values, null)
  reset_values               = try(var.cloudwatch_metrics.reset_values, null)
  force_update               = try(var.cloudwatch_metrics.force_update, null)
  recreate_pods              = try(var.cloudwatch_metrics.recreate_pods, null)
  cleanup_on_fail            = try(var.cloudwatch_metrics.cleanup_on_fail, null)
  max_history                = try(var.cloudwatch_metrics.max_history, null)
  atomic                     = try(var.cloudwatch_metrics.atomic, null)
  skip_crds                  = try(var.cloudwatch_metrics.skip_crds, null)
  render_subchart_notes      = try(var.cloudwatch_metrics.render_subchart_notes, null)
  disable_openapi_validation = try(var.cloudwatch_metrics.disable_openapi_validation, null)
  wait                       = try(var.cloudwatch_metrics.wait, null)
  wait_for_jobs              = try(var.cloudwatch_metrics.wait_for_jobs, null)
  dependency_update          = try(var.cloudwatch_metrics.dependency_update, null)
  replace                    = try(var.cloudwatch_metrics.replace, null)
  lint                       = try(var.cloudwatch_metrics.lint, null)

  postrender = try(var.cloudwatch_metrics.postrender, [])
  set = concat([
    {
      name  = "clusterName"
      value = var.cluster_name
      }, {
      name  = "serviceAccount.name"
      value = local.cloudwatch_metrics_service_account
    }],
    try(var.cloudwatch_metrics.set, [])
  )
  set_sensitive = try(var.cloudwatch_metrics.set_sensitive, [])

  # IAM role for service account (IRSA)
  set_irsa_name                 = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  create_role                   = try(var.cloudwatch_metrics.create_role, true)
  role_name                     = try(var.cloudwatch_metrics.role_name, "aws-cloudwatch-metrics")
  role_name_use_prefix          = try(var.cloudwatch_metrics.role_name_use_prefix, true)
  role_path                     = try(var.cloudwatch_metrics.role_path, "/")
  role_permissions_boundary_arn = try(var.cloudwatch_metrics.role_permissions_boundary_arn, null)
  role_description              = try(var.cloudwatch_metrics.role_description, "IRSA for aws-cloudwatch-metrics project")
  role_policies = lookup(var.cloudwatch_metrics, "role_policies",
    { CloudWatchAgentServerPolicy = "arn:${local.partition}:iam::aws:policy/CloudWatchAgentServerPolicy" }
  )

  oidc_providers = {
    this = {
      provider_arn = var.oidc_provider_arn
      # namespace is inherited from chart
      service_account = local.cloudwatch_metrics_service_account
    }
  }

  tags = var.tags
}

################################################################################
# EFS CSI DRIVER
################################################################################

locals {
  efs_csi_driver_service_account = try(var.efs_csi_driver.service_account_name, "efs-csi-controller-sa")
  efs_arns = lookup(var.efs_csi_driver, "efs_arns",
    ["arn:${local.partition}:elasticfilesystem:${local.region}:${local.account_id}:file-system/*"],
  )
  efs_access_point_arns = lookup(var.efs_csi_driver, "efs_access_point_arns",
    ["arn:${local.partition}:elasticfilesystem:${local.region}:${local.account_id}:access-point/*"]
  )
}

data "aws_iam_policy_document" "efs_csi_driver" {
  count = var.enable_efs_csi_driver ? 1 : 0

  statement {
    sid       = "AllowDescribeAvailabilityZones"
    actions   = ["ec2:DescribeAvailabilityZones"]
    resources = ["*"]
  }

  statement {
    sid = "AllowDescribeFileSystems"
    actions = [
      "elasticfilesystem:DescribeAccessPoints",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeMountTargets"
    ]
    resources = flatten([
      local.efs_arns,
      local.efs_access_point_arns,
    ])
  }

  statement {
    sid       = "AllowCreateAccessPoint"
    actions   = ["elasticfilesystem:CreateAccessPoint"]
    resources = local.efs_arns

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }

  statement {
    sid       = "AllowDeleteAccessPoint"
    actions   = ["elasticfilesystem:DeleteAccessPoint"]
    resources = local.efs_access_point_arns

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }

  statement {
    sid = "ClientReadWrite"
    actions = [
      "elasticfilesystem:ClientRootAccess",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientMount",
    ]
    resources = local.efs_arns

    condition {
      test     = "Bool"
      variable = "elasticfilesystem:AccessedViaMountTarget"
      values   = ["true"]
    }
  }
}

module "efs_csi_driver" {
  # source = "aws-ia/eks-blueprints-addon/aws"
  source = "./modules/eks-blueprints-addon"

  create = var.enable_efs_csi_driver

  # https://github.com/kubernetes-sigs/aws-efs-csi-driver/tree/master/charts/aws-efs-csi-driver
  name             = try(var.efs_csi_driver.name, "aws-efs-csi-driver")
  description      = try(var.efs_csi_driver.description, "A Helm chart to deploy aws-efs-csi-driver")
  namespace        = try(var.efs_csi_driver.namespace, "kube-system")
  create_namespace = try(var.efs_csi_driver.create_namespace, false)
  chart            = "aws-efs-csi-driver"
  chart_version    = try(var.efs_csi_driver.chart_version, "2.4.1")
  repository       = try(var.efs_csi_driver.repository, "https://kubernetes-sigs.github.io/aws-efs-csi-driver/")
  values           = try(var.efs_csi_driver.values, [])

  timeout                    = try(var.efs_csi_driver.timeout, null)
  repository_key_file        = try(var.efs_csi_driver.repository_key_file, null)
  repository_cert_file       = try(var.efs_csi_driver.repository_cert_file, null)
  repository_ca_file         = try(var.efs_csi_driver.repository_ca_file, null)
  repository_username        = try(var.efs_csi_driver.repository_username, null)
  repository_password        = try(var.efs_csi_driver.repository_password, null)
  devel                      = try(var.efs_csi_driver.devel, null)
  verify                     = try(var.efs_csi_driver.verify, null)
  keyring                    = try(var.efs_csi_driver.keyring, null)
  disable_webhooks           = try(var.efs_csi_driver.disable_webhooks, null)
  reuse_values               = try(var.efs_csi_driver.reuse_values, null)
  reset_values               = try(var.efs_csi_driver.reset_values, null)
  force_update               = try(var.efs_csi_driver.force_update, null)
  recreate_pods              = try(var.efs_csi_driver.recreate_pods, null)
  cleanup_on_fail            = try(var.efs_csi_driver.cleanup_on_fail, null)
  max_history                = try(var.efs_csi_driver.max_history, null)
  atomic                     = try(var.efs_csi_driver.atomic, null)
  skip_crds                  = try(var.efs_csi_driver.skip_crds, null)
  render_subchart_notes      = try(var.efs_csi_driver.render_subchart_notes, null)
  disable_openapi_validation = try(var.efs_csi_driver.disable_openapi_validation, null)
  wait                       = try(var.efs_csi_driver.wait, null)
  wait_for_jobs              = try(var.efs_csi_driver.wait_for_jobs, null)
  dependency_update          = try(var.efs_csi_driver.dependency_update, null)
  replace                    = try(var.efs_csi_driver.replace, null)
  lint                       = try(var.efs_csi_driver.lint, null)

  postrender = try(var.efs_csi_driver.postrender, [])
  set = concat([
    {
      name  = "clusterName"
      value = var.cluster_name
      }, {
      name  = "controller.serviceAccount.name"
      value = local.efs_csi_driver_service_account
    }],
    try(var.efs_csi_driver.set, [])
  )
  set_sensitive = try(var.efs_csi_driver.set_sensitive, [])

  # IAM role for service account (IRSA)
  create_role                   = try(var.efs_csi_driver.create_role, true)
  role_name                     = try(var.efs_csi_driver.role_name, "aws-efs-csi-driver")
  role_name_use_prefix          = try(var.efs_csi_driver.role_name_use_prefix, true)
  role_path                     = try(var.efs_csi_driver.role_path, "/")
  role_permissions_boundary_arn = lookup(var.efs_csi_driver, "role_permissions_boundary_arn", null)
  role_description              = try(var.efs_csi_driver.role_description, "IRSA for aws-efs-csi-driver project")
  role_policies                 = lookup(var.efs_csi_driver, "role_policies", {})

  source_policy_documents = compact(concat(
    data.aws_iam_policy_document.efs_csi_driver[*].json,
    lookup(var.efs_csi_driver, "source_policy_documents", [])
  ))
  override_policy_documents = lookup(var.efs_csi_driver, "override_policy_documents", [])
  policy_statements         = lookup(var.efs_csi_driver, "policy_statements", [])
  policy_name               = try(var.efs_csi_driver.policy_name, null)
  policy_name_use_prefix    = try(var.efs_csi_driver.policy_name_use_prefix, true)
  policy_path               = try(var.efs_csi_driver.policy_path, null)
  policy_description        = try(var.efs_csi_driver.policy_description, "IAM Policy for AWS EFS CSI Driver")

  oidc_providers = {
    this = {
      provider_arn = var.oidc_provider_arn
      # namespace is inherited from chart
      service_account = local.efs_csi_driver_service_account
    }
  }

  tags = var.tags
}

################################################################################
# External Secrets
################################################################################

locals {
  external_secrets_service_account = try(var.external_secrets.service_account_name, "external-secrets-sa")
}

# https://github.com/external-secrets/kubernetes-external-secrets#add-a-secret
data "aws_iam_policy_document" "external_secrets" {
  count = var.enable_external_secrets ? 1 : 0

  dynamic "statement" {
    for_each = length(var.external_secrets_ssm_parameter_arns) > 0 ? [1] : []

    content {
      actions   = ["ssm:DescribeParameters"]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = length(var.external_secrets_ssm_parameter_arns) > 0 ? [1] : []

    content {
      actions = [
        "ssm:GetParameter",
        "ssm:GetParameters",
      ]
      resources = var.external_secrets_ssm_parameter_arns
    }
  }

  dynamic "statement" {
    for_each = length(var.external_secrets_secrets_manager_arns) > 0 ? [1] : []

    content {
      actions   = ["secretsmanager:ListSecrets"]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = length(var.external_secrets_secrets_manager_arns) > 0 ? [1] : []

    content {
      actions = [
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds",
      ]
      resources = var.external_secrets_secrets_manager_arns
    }
  }

  dynamic "statement" {
    for_each = length(var.external_secrets_kms_key_arns) > 0 ? [1] : []

    content {
      actions   = ["kms:Decrypt"]
      resources = var.external_secrets_kms_key_arns
    }
  }
}

module "external_secrets" {
  # source = "aws-ia/eks-blueprints-addon/aws"
  source = "./modules/eks-blueprints-addon"

  create = var.enable_external_secrets

  # https://github.com/external-secrets/external-secrets/blob/main/deploy/charts/external-secrets/Chart.yaml
  name             = try(var.external_secrets.name, "external-secrets")
  description      = try(var.external_secrets.description, "A Helm chart to deploy external-secrets")
  namespace        = try(var.external_secrets.namespace, "external-secrets")
  create_namespace = try(var.external_secrets.create_namespace, true)
  chart            = "external-secrets"
  chart_version    = try(var.external_secrets.chart_version, "0.8.1")
  repository       = try(var.external_secrets.repository, "https://kubernetes-sigs.github.io/aws-efs-csi-driver/")
  values           = try(var.external_secrets.values, [])

  timeout                    = try(var.external_secrets.timeout, null)
  repository_key_file        = try(var.external_secrets.repository_key_file, null)
  repository_cert_file       = try(var.external_secrets.repository_cert_file, null)
  repository_ca_file         = try(var.external_secrets.repository_ca_file, null)
  repository_username        = try(var.external_secrets.repository_username, null)
  repository_password        = try(var.external_secrets.repository_password, null)
  devel                      = try(var.external_secrets.devel, null)
  verify                     = try(var.external_secrets.verify, null)
  keyring                    = try(var.external_secrets.keyring, null)
  disable_webhooks           = try(var.external_secrets.disable_webhooks, null)
  reuse_values               = try(var.external_secrets.reuse_values, null)
  reset_values               = try(var.external_secrets.reset_values, null)
  force_update               = try(var.external_secrets.force_update, null)
  recreate_pods              = try(var.external_secrets.recreate_pods, null)
  cleanup_on_fail            = try(var.external_secrets.cleanup_on_fail, null)
  max_history                = try(var.external_secrets.max_history, null)
  atomic                     = try(var.external_secrets.atomic, null)
  skip_crds                  = try(var.external_secrets.skip_crds, null)
  render_subchart_notes      = try(var.external_secrets.render_subchart_notes, null)
  disable_openapi_validation = try(var.external_secrets.disable_openapi_validation, null)
  wait                       = try(var.external_secrets.wait, null)
  wait_for_jobs              = try(var.external_secrets.wait_for_jobs, null)
  dependency_update          = try(var.external_secrets.dependency_update, null)
  replace                    = try(var.external_secrets.replace, null)
  lint                       = try(var.external_secrets.lint, null)

  postrender = try(var.external_secrets.postrender, [])
  set = concat([
    {
      name  = "serviceAccount.name"
      value = local.external_secrets_service_account
    }],
    try(var.external_secrets.set, [])
  )
  set_sensitive = try(var.external_secrets.set_sensitive, [])

  # IAM role for service account (IRSA)
  set_irsa_name                 = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  create_role                   = try(var.external_secrets.create_role, true)
  role_name                     = try(var.external_secrets.role_name, "external-secrets")
  role_name_use_prefix          = try(var.external_secrets.role_name_use_prefix, true)
  role_path                     = try(var.external_secrets.role_path, "/")
  role_permissions_boundary_arn = lookup(var.external_secrets, "role_permissions_boundary_arn", null)
  role_description              = try(var.external_secrets.role_description, "IRSA for external-secrets operator")
  role_policies                 = lookup(var.external_secrets, "role_policies", {})

  source_policy_documents = compact(concat(
    data.aws_iam_policy_document.external_secrets[*].json,
    lookup(var.external_secrets, "source_policy_documents", [])
  ))
  override_policy_documents = lookup(var.external_secrets, "override_policy_documents", [])
  policy_statements         = lookup(var.external_secrets, "policy_statements", [])
  policy_name               = try(var.external_secrets.policy_name, null)
  policy_name_use_prefix    = try(var.external_secrets.policy_name_use_prefix, true)
  policy_path               = try(var.external_secrets.policy_path, null)
  policy_description        = try(var.external_secrets.policy_description, "IAM Policy for external-secrets operator")

  oidc_providers = {
    this = {
      provider_arn = var.oidc_provider_arn
      # namespace is inherited from chart
      service_account = local.external_secrets_service_account
    }
  }

  tags = var.tags
}

################################################################################
# AWS Load Balancer Controller
################################################################################

locals {
  aws_load_balancer_controller_name = "aws-load-balancer-controller"
  aws_load_balancer_controller_service_account = try(var.aws_load_balancer_controller.service_account_name, "${local.aws_load_balancer_controller_name}-sa")
}

data "aws_iam_policy_document" "aws_load_balancer_controller" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["iam:CreateServiceLinkedRole"]

    condition {
      test     = "StringEquals"
      variable = "iam:AWSServiceName"
      values   = ["elasticloadbalancing.amazonaws.com"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeCoipPools",
      "ec2:DescribeInstances",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeVpcs",
      "ec2:GetCoipPoolUsage",
      "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "acm:DescribeCertificate",
      "acm:ListCertificates",
      "cognito-idp:DescribeUserPoolClient",
      "iam:GetServerCertificate",
      "iam:ListServerCertificates",
      "shield:CreateProtection",
      "shield:DeleteProtection",
      "shield:DescribeProtection",
      "shield:GetSubscriptionState",
      "waf-regional:AssociateWebACL",
      "waf-regional:DisassociateWebACL",
      "waf-regional:GetWebACL",
      "waf-regional:GetWebACLForResource",
      "wafv2:AssociateWebACL",
      "wafv2:DisassociateWebACL",
      "wafv2:GetWebACL",
      "wafv2:GetWebACLForResource",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["ec2:CreateSecurityGroup"]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:${var.addon_context.aws_partition_id}:ec2:*:*:security-group/*"]
    actions   = ["ec2:CreateTags"]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"
      values   = ["CreateSecurityGroup"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:${var.addon_context.aws_partition_id}:ec2:*:*:security-group/*"]

    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags",
    ]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/ingress.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    sid    = ""
    effect = "Allow"

    resources = [
      "arn:${var.addon_context.aws_partition_id}:elasticloadbalancing:*:*:loadbalancer/app/*/*",
      "arn:${var.addon_context.aws_partition_id}:elasticloadbalancing:*:*:loadbalancer/net/*/*",
      "arn:${var.addon_context.aws_partition_id}:elasticloadbalancing:*:*:targetgroup/*/*",
    ]

    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:RemoveTags",
    ]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/ingress.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:${var.addon_context.aws_partition_id}:ec2:*:*:security-group/*"]

    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags",
    ]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["true"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:DeleteSecurityGroup",
      "ec2:RevokeSecurityGroupIngress",
    ]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateTargetGroup",
    ]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:CreateRule",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:DeleteRule",
    ]
  }

  statement {
    sid    = ""
    effect = "Allow"

    resources = [
      "arn:${var.addon_context.aws_partition_id}:elasticloadbalancing:*:*:loadbalancer/app/*/*",
      "arn:${var.addon_context.aws_partition_id}:elasticloadbalancing:*:*:loadbalancer/net/*/*",
      "arn:${var.addon_context.aws_partition_id}:elasticloadbalancing:*:*:targetgroup/*/*",
    ]

    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags",
    ]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["true"]
    }

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    sid    = ""
    effect = "Allow"

    resources = [
      "arn:${var.addon_context.aws_partition_id}:elasticloadbalancing:*:*:listener/net/*/*/*",
      "arn:${var.addon_context.aws_partition_id}:elasticloadbalancing:*:*:listener/app/*/*/*",
      "arn:${var.addon_context.aws_partition_id}:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
      "arn:${var.addon_context.aws_partition_id}:elasticloadbalancing:*:*:listener-rule/app/*/*/*",
    ]

    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:SetIpAddressType",
      "elasticloadbalancing:SetSecurityGroups",
      "elasticloadbalancing:SetSubnets",
    ]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:${var.addon_context.aws_partition_id}:elasticloadbalancing:*:*:targetgroup/*/*"]

    actions = [
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:RegisterTargets",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "elasticloadbalancing:AddListenerCertificates",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyRule",
      "elasticloadbalancing:RemoveListenerCertificates",
      "elasticloadbalancing:SetWebAcl",
    ]
  }
}

module "aws_load_balancer_controller" {
  # source = "aws-ia/eks-blueprints-addon/aws"
  source = "./modules/eks-blueprints-addon"

  create = var.enable_aws_load_balancer_controller

  # https://github.com/aws/eks-charts/blob/master/stable/aws-load-balancer-controller/Chart.yaml
  name             = try(var.aws_load_balancer_controller.name, local.aws_load_balancer_controller_name)
  description      = try(var.aws_load_balancer_controller.description, "A Helm chart to deploy aws-load-balancer-controller for ingress resources")
  namespace        = try(var.aws_load_balancer_controller.namespace, "kube-system")
  # namespace creation is false here as kube-system already exists by default
  create_namespace = try(var.aws_load_balancer_controller.create_namespace, false)
  chart            = local.aws_load_balancer_controller_name
  chart_version    = try(var.aws_load_balancer_controller.chart_version, "1.4.8")
  repository       = try(var.aws_load_balancer_controller.repository, "https://aws.github.io/eks-charts")
  values           = try(var.aws_load_balancer_controller.values, [])

  timeout                    = try(var.aws_load_balancer_controller.timeout, null)
  repository_key_file        = try(var.aws_load_balancer_controller.repository_key_file, null)
  repository_cert_file       = try(var.aws_load_balancer_controller.repository_cert_file, null)
  repository_ca_file         = try(var.aws_load_balancer_controller.repository_ca_file, null)
  repository_username        = try(var.aws_load_balancer_controller.repository_username, null)
  repository_password        = try(var.aws_load_balancer_controller.repository_password, null)
  devel                      = try(var.aws_load_balancer_controller.devel, null)
  verify                     = try(var.aws_load_balancer_controller.verify, null)
  keyring                    = try(var.aws_load_balancer_controller.keyring, null)
  disable_webhooks           = try(var.aws_load_balancer_controller.disable_webhooks, null)
  reuse_values               = try(var.aws_load_balancer_controller.reuse_values, null)
  reset_values               = try(var.aws_load_balancer_controller.reset_values, null)
  force_update               = try(var.aws_load_balancer_controller.force_update, null)
  recreate_pods              = try(var.aws_load_balancer_controller.recreate_pods, null)
  cleanup_on_fail            = try(var.aws_load_balancer_controller.cleanup_on_fail, null)
  max_history                = try(var.aws_load_balancer_controller.max_history, null)
  atomic                     = try(var.aws_load_balancer_controller.atomic, null)
  skip_crds                  = try(var.aws_load_balancer_controller.skip_crds, null)
  render_subchart_notes      = try(var.aws_load_balancer_controller.render_subchart_notes, null)
  disable_openapi_validation = try(var.aws_load_balancer_controller.disable_openapi_validation, null)
  wait                       = try(var.aws_load_balancer_controller.wait, null)
  wait_for_jobs              = try(var.aws_load_balancer_controller.wait_for_jobs, null)
  dependency_update          = try(var.aws_load_balancer_controller.dependency_update, null)
  replace                    = try(var.aws_load_balancer_controller.replace, null)
  lint                       = try(var.aws_load_balancer_controller.lint, null)

  postrender = try(var.aws_load_balancer_controller.postrender, [])
  set = concat([
    {
      name  = "clusterName"
      value = var.cluster_name
      }, {
      name  = "controller.serviceAccount.name"
      value = local.aws_load_balancer_controller_service_account
    }],
    try(var.aws_load_balancer_controller.set, [])
  )
  set_sensitive = try(var.aws_load_balancer_controller.set_sensitive, [])

  # IAM role for service account (IRSA)
  create_role                   = try(var.aws_load_balancer_controller.create_role, true)
  role_name                     = try(var.aws_load_balancer_controller.role_name, local.aws_load_balancer_controller_name)
  role_name_use_prefix          = try(var.aws_load_balancer_controller.role_name_use_prefix, true)
  role_path                     = try(var.aws_load_balancer_controller.role_path, "/")
  role_permissions_boundary_arn = lookup(var.aws_load_balancer_controller, "role_permissions_boundary_arn", null)
  role_description              = try(var.aws_load_balancer_controller.role_description, "IRSA for aws-load-balancer-controller project")
  role_policies                 = lookup(var.aws_load_balancer_controller, "role_policies", {})

  source_policy_documents = compact(concat(
    data.aws_iam_policy_document.aws_load_balancer_controller[*].json,
    lookup(var.aws_load_balancer_controller, "source_policy_documents", [])
  ))
  override_policy_documents = lookup(var.aws_load_balancer_controller, "override_policy_documents", [])
  policy_statements         = lookup(var.aws_load_balancer_controller, "policy_statements", [])
  policy_name               = try(var.aws_load_balancer_controller.policy_name, null)
  policy_name_use_prefix    = try(var.aws_load_balancer_controller.policy_name_use_prefix, true)
  policy_path               = try(var.aws_load_balancer_controller.policy_path, null)
  policy_description        = try(var.aws_load_balancer_controller.policy_description, "IAM Policy for AWS Load Balancer Controller")

  oidc_providers = {
    this = {
      provider_arn = var.oidc_provider_arn
      # namespace is inherited from chart
      service_account = local.aws_load_balancer_controller_service_account
    }
  }

  tags = var.tags
}

#-----------------Kubernetes Add-ons----------------------

module "argocd" {
  count         = var.enable_argocd ? 1 : 0
  source        = "./modules/argocd"
  helm_config   = var.argocd_helm_config
  applications  = var.argocd_applications
  projects      = var.argocd_projects
  addon_config  = { for k, v in local.argocd_addon_config : k => v if v != null }
  addon_context = local.addon_context
}

module "aws_fsx_csi_driver" {
  count             = var.enable_aws_fsx_csi_driver ? 1 : 0
  source            = "./modules/aws-fsx-csi-driver"
  helm_config       = var.aws_fsx_csi_driver_helm_config
  irsa_policies     = var.aws_fsx_csi_driver_irsa_policies
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}

module "aws_for_fluent_bit" {
  count                     = var.enable_aws_for_fluentbit ? 1 : 0
  source                    = "./modules/aws-for-fluentbit"
  helm_config               = var.aws_for_fluentbit_helm_config
  irsa_policies             = var.aws_for_fluentbit_irsa_policies
  create_cw_log_group       = var.aws_for_fluentbit_create_cw_log_group
  cw_log_group_name         = var.aws_for_fluentbit_cw_log_group_name
  cw_log_group_retention    = var.aws_for_fluentbit_cw_log_group_retention
  cw_log_group_skip_destroy = var.aws_for_fluentbit_cw_log_group_skip_destroy
  cw_log_group_kms_key_arn  = var.aws_for_fluentbit_cw_log_group_kms_key_arn
  manage_via_gitops         = var.argocd_manage_add_ons
  addon_context             = local.addon_context
}

module "aws_load_balancer_controller" {
  count             = var.enable_aws_load_balancer_controller ? 1 : 0
  source            = "./modules/aws-load-balancer-controller"
  helm_config       = var.aws_load_balancer_controller_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = merge(local.addon_context, { default_repository = local.amazon_container_image_registry_uris[data.aws_region.current.name] })
}

module "aws_node_termination_handler" {
  count                   = var.enable_aws_node_termination_handler && (length(var.auto_scaling_group_names) > 0 || var.enable_karpenter) ? 1 : 0
  source                  = "./modules/aws-node-termination-handler"
  helm_config             = var.aws_node_termination_handler_helm_config
  manage_via_gitops       = var.argocd_manage_add_ons
  irsa_policies           = var.aws_node_termination_handler_irsa_policies
  autoscaling_group_names = var.auto_scaling_group_names
  addon_context           = local.addon_context
}

module "cert_manager" {
  count                             = var.enable_cert_manager ? 1 : 0
  source                            = "./modules/cert-manager"
  helm_config                       = var.cert_manager_helm_config
  manage_via_gitops                 = var.argocd_manage_add_ons
  irsa_policies                     = var.cert_manager_irsa_policies
  addon_context                     = local.addon_context
  domain_names                      = var.cert_manager_domain_names
  install_letsencrypt_issuers       = var.cert_manager_install_letsencrypt_issuers
  letsencrypt_email                 = var.cert_manager_letsencrypt_email
  kubernetes_svc_image_pull_secrets = var.cert_manager_kubernetes_svc_image_pull_secrets
}

module "cluster_autoscaler" {
  source = "./modules/cluster-autoscaler"

  count = var.enable_cluster_autoscaler ? 1 : 0

  eks_cluster_version = var.cluster_version
  helm_config         = var.cluster_autoscaler_helm_config
  manage_via_gitops   = var.argocd_manage_add_ons
  addon_context       = local.addon_context
}

module "external_dns" {
  source = "./modules/external-dns"

  count = var.enable_external_dns ? 1 : 0

  helm_config       = var.external_dns_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  irsa_policies     = var.external_dns_irsa_policies
  addon_context     = local.addon_context

  route53_zone_arns = var.external_dns_route53_zone_arns
}

module "fargate_fluentbit" {
  count         = var.enable_fargate_fluentbit ? 1 : 0
  source        = "./modules/fargate-fluentbit"
  addon_config  = var.fargate_fluentbit_addon_config
  addon_context = local.addon_context
}

module "grafana" {
  count             = var.enable_grafana ? 1 : 0
  source            = "./modules/grafana"
  helm_config       = var.grafana_helm_config
  irsa_policies     = var.grafana_irsa_policies
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}

module "ingress_nginx" {
  count             = var.enable_ingress_nginx ? 1 : 0
  source            = "./modules/ingress-nginx"
  helm_config       = var.ingress_nginx_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}

module "karpenter" {
  source = "./modules/karpenter"

  count = var.enable_karpenter ? 1 : 0

  helm_config                                 = var.karpenter_helm_config
  irsa_policies                               = var.karpenter_irsa_policies
  node_iam_instance_profile                   = var.karpenter_node_iam_instance_profile
  enable_spot_termination                     = var.karpenter_enable_spot_termination_handling
  rule_name_prefix                            = var.karpenter_event_rule_name_prefix
  manage_via_gitops                           = var.argocd_manage_add_ons
  addon_context                               = local.addon_context
  sqs_queue_managed_sse_enabled               = var.sqs_queue_managed_sse_enabled
  sqs_queue_kms_master_key_id                 = var.sqs_queue_kms_master_key_id
  sqs_queue_kms_data_key_reuse_period_seconds = var.sqs_queue_kms_data_key_reuse_period_seconds
}

module "metrics_server" {
  count             = var.enable_metrics_server ? 1 : 0
  source            = "./modules/metrics-server"
  helm_config       = var.metrics_server_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}

module "kube_prometheus_stack" {
  count             = var.enable_kube_prometheus_stack ? 1 : 0
  source            = "./modules/kube-prometheus-stack"
  helm_config       = var.kube_prometheus_stack_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}

module "prometheus" {
  count       = var.enable_prometheus ? 1 : 0
  source      = "./modules/prometheus"
  helm_config = var.prometheus_helm_config
  #AWS Managed Prometheus Workspace
  enable_amazon_prometheus             = var.enable_amazon_prometheus
  amazon_prometheus_workspace_endpoint = var.amazon_prometheus_workspace_endpoint
  manage_via_gitops                    = var.argocd_manage_add_ons
  addon_context                        = local.addon_context
}

module "vpa" {
  count             = var.enable_vpa ? 1 : 0
  source            = "./modules/vpa"
  helm_config       = var.vpa_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}

module "csi_secrets_store_provider_aws" {
  count             = var.enable_secrets_store_csi_driver_provider_aws ? 1 : 0
  source            = "./modules/csi-secrets-store-provider-aws"
  helm_config       = var.csi_secrets_store_provider_aws_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}

module "secrets_store_csi_driver" {
  count             = var.enable_secrets_store_csi_driver ? 1 : 0
  source            = "./modules/secrets-store-csi-driver"
  helm_config       = var.secrets_store_csi_driver_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}

module "aws_privateca_issuer" {
  count                   = var.enable_aws_privateca_issuer ? 1 : 0
  source                  = "./modules/aws-privateca-issuer"
  helm_config             = var.aws_privateca_issuer_helm_config
  manage_via_gitops       = var.argocd_manage_add_ons
  addon_context           = local.addon_context
  aws_privateca_acmca_arn = var.aws_privateca_acmca_arn
  irsa_policies           = var.aws_privateca_issuer_irsa_policies
}

module "velero" {
  count             = var.enable_velero ? 1 : 0
  source            = "./modules/velero"
  helm_config       = var.velero_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
  irsa_policies     = var.velero_irsa_policies
  backup_s3_bucket  = var.velero_backup_s3_bucket
}

module "opentelemetry_operator" {
  source = "./modules/opentelemetry-operator"

  count = var.enable_amazon_eks_adot || var.enable_opentelemetry_operator ? 1 : 0

  # Amazon EKS ADOT addon
  enable_amazon_eks_adot = var.enable_amazon_eks_adot
  addon_config = merge(
    {
      kubernetes_version = var.cluster_version
    },
    var.amazon_eks_adot_config,
  )

  # Self-managed OpenTelemetry Operator via Helm chart
  enable_opentelemetry_operator = var.enable_opentelemetry_operator
  helm_config                   = var.opentelemetry_operator_helm_config

  addon_context = local.addon_context
}

module "promtail" {
  source = "./modules/promtail"

  count = var.enable_promtail ? 1 : 0

  helm_config       = var.promtail_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}

module "gatekeeper" {
  source = "./modules/gatekeeper"

  count = var.enable_gatekeeper ? 1 : 0

  helm_config       = var.gatekeeper_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}
