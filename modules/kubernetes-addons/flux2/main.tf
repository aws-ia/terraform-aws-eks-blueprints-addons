module "flux2" {
  source  = "aws-ia/eks-blueprints-addon/aws"
  version = "1.1.1"

  create = var.create

  # Disable helm release
  create_release = var.create_kubernetes_resources

  # https://github.com/fluxcd-community/helm-charts/blob/main/charts/flux2/
  name             = local.addon_name
  description      = local.addon_description
  namespace        = local.addon_namespace
  create_namespace = coalesce(try(var.addon_defs.create_namespace, null), true)
  chart            = local.addon_chart
  chart_version    = local.addon_chart_version
  repository       = local.addon_repository
  values           = local.addon_values

  timeout                    = try(var.addon_defs.timeout, null)
  repository_key_file        = try(var.addon_defs.repository_key_file, null)
  repository_cert_file       = try(var.addon_defs.repository_cert_file, null)
  repository_ca_file         = try(var.addon_defs.repository_ca_file, null)
  repository_username        = try(var.addon_defs.repository_username, null)
  repository_password        = try(var.addon_defs.repository_password, null)
  devel                      = try(var.addon_defs.devel, null)
  verify                     = try(var.addon_defs.verify, null)
  keyring                    = try(var.addon_defs.keyring, null)
  disable_webhooks           = try(var.addon_defs.disable_webhooks, null)
  reuse_values               = try(var.addon_defs.reuse_values, null)
  reset_values               = try(var.addon_defs.reset_values, null)
  force_update               = try(var.addon_defs.force_update, null)
  recreate_pods              = try(var.addon_defs.recreate_pods, null)
  cleanup_on_fail            = try(var.addon_defs.cleanup_on_fail, null)
  max_history                = try(var.addon_defs.max_history, null)
  atomic                     = try(var.addon_defs.atomic, null)
  skip_crds                  = try(var.addon_defs.skip_crds, null)
  render_subchart_notes      = try(var.addon_defs.render_subchart_notes, null)
  disable_openapi_validation = try(var.addon_defs.disable_openapi_validation, null)
  wait                       = try(var.addon_defs.wait, false)
  wait_for_jobs              = try(var.addon_defs.wait_for_jobs, null)
  dependency_update          = try(var.addon_defs.dependency_update, null)
  replace                    = try(var.addon_defs.replace, null)
  lint                       = try(var.addon_defs.lint, null)

  postrender = try(var.addon_defs.postrender, [])

  set = try(var.addon_defs.set, [])
  set_sensitive = try(var.addon_defs.set_sensitive, [])

  # IAM role for service account (IRSA)
  # 231005-JC: TODO: review decision to map maps all controllers to a single IAM role, based on (https://github.com/aws-ia/terraform-aws-eks-blueprints-addons/issues/26)
  set_irsa_names = [
    for c, c_spec in local.controllers_irsa : join(".", [
          c_spec.helm_sa_annotations,
          "eks\\.amazonaws\\.com/role-arn",
        ]) if (c_spec.helm_sa_annotations!=null)
  ]

  create_role                   = try(var.addon_defs.create_role, true)
  role_name                     = try(var.addon_defs.role_name, "flux2-all") # 231005-JC: keeping "-all" suffix for now to make it explicit we are mapping all controllers here
  role_name_use_prefix          = try(var.addon_defs.role_name_use_prefix, true)
  role_path                     = try(var.addon_defs.role_path, "/")
  role_permissions_boundary_arn = try(var.addon_defs.role_permissions_boundary_arn, null)
  role_description              = try(var.addon_defs.role_description, "IRSA for Flux v2 project (multiple controllers)")
  role_policies                 = try(var.addon_defs.role_policies, {})

  source_policy_documents = data.aws_iam_policy_document.aws_efs_csi_driver[*].json
  policy_statements       = try(var.aws_efs_csi_driver.policy_statements, [])
  policy_name             = try(var.addon_defs.policy_name, null)
  policy_name_use_prefix  = try(var.addon_defs.policy_name_use_prefix, true)
  policy_path             = try(var.addon_defs.policy_path, null)
  policy_description      = try(var.addon_defs.policy_description, "IAM Policy for Flux v2 (multiple controllers)")

  oidc_providers = {
    for c, c_spec in local.controllers_irsa : controller_helm_base => {
        provider_arn = local.oidc_provider_arn
        # namespace is inherited from chart
        service_account = c_spec.sa_name
      } if (c_spec.sa_name != null)
  }

  tags = var.tags
}

