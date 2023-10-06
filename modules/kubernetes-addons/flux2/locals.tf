locals {
  # data "aws_partition" "current" {}
  # data "aws_caller_identity" "current" {}
  # data "aws_region" "current" {}

  defaults = {
    name      = "flux2"
    namespace = "flux-system"

    chart         = "flux2"
    chart_version = "2.10.1"  # using non-exact version specifiers ("~X.Y.Z") will cause helm_release to always detect changes!!!
    repository    = "https://fluxcd-community.github.io/helm-charts"

    description = "A Helm chart to deploy Flux v2"
  }

  addon_name        = coalesce(try(var.addon_defs.name, null), local.defaults.name)
  addon_namespace   = coalesce(try(var.addon_defs.namespace, null), local.defaults.namespace)
  addon_description = coalesce(try(var.addon_defs.description, null), local.defaults.description)

  addon_chart         = coalesce(try(var.addon_defs.chart, null), local.defaults.chart)
  addon_chart_version = coalesce(try(var.addon_defs.chart_version, null), local.defaults.chart_version)
  addon_repository    = coalesce(try(var.addon_defs.repository, null), local.defaults.repository)

  addon_values = try(var.addon_defs.values, [])

  create_role = try(var.addon_defs.create_role, true)

  # it seems flux2 doesn't allow customization of service account (as per https://github.com/fluxcd-community/helm-charts/issues/191)
  # so we hardwiring the names to be used in policies

  # we only need to specify entries for SAs that need to be enabled for IRSA
  # in this case, https://fluxcd.io/flux/installation/configuration/workload-identity/#aws-iam-roles-for-service-accounts
  #
  # key - used in gitops_metadata name dict
  # sa_name - used to specify service name
  # helm_sa_annotations - used to define the Helm yaml path in values.yaml where annotations for each service need to be set

  controllers_irsa = {

    "source"           = { sa_name = "source-controller",           helm_sa_annotations = "sourceController.serviceAccount.annotations" }
    "kustomize"        = { sa_name = "kustomize-controller",        helm_sa_annotations = "kustomizeController.serviceAccount.annotations" }
    "image_reflector"  = { sa_name = "image-reflector-controller",  helm_sa_annotations = "imageReflectorController.serviceAccount.annotations" }
    # "helm"             = { sa_name = "helm-controller",             helm_base = "helmController.serviceAccount.annotations" }
    # "notification"     = { sa_name = "notification-controller",     helm_base = "notificationController.serviceAccount.annotations" }
    # "image_automation" = { sa_name = "image-automation-controller", helm_base = "imageAutomationController.serviceAccount.annotations" }
  }

  source_buckets_s3_names = toset(try(var.source_buckets_s3_names, []))
  kustomize_sops_kms_arns = toset(try(var.kustomize_sops_kms_arns, [
    # TODO: consider whether to add the a default KMS alias - will require adding data sources to translate to ARNs and would only make sense if there is a natural alias
  ]))
}
