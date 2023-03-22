locals {
  default_helm_values = [file("${path.module}/values.yaml")]

  name      = "argo-cd"
  namespace = "argocd"

  # https://github.com/argoproj/argo-helm/blob/main/charts/argo-cd/Chart.yaml
  default_helm_config = {
    name             = local.name
    chart            = local.name
    repository       = "https://argoproj.github.io/argo-helm"
    version          = "5.27.1" # ArgoCD v2.6.6
    namespace        = local.namespace
    create_namespace = true
    values           = local.default_helm_values
    description      = "The ArgoCD Helm Chart deployment configuration"
    wait             = false
    timeout          = 1200
  }

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  default_argocd_application = {
    namespace          = local.helm_config["namespace"]
    target_revision    = "HEAD"
    destination        = "https://kubernetes.default.svc"
    project            = "default"
    values             = {}
    type               = "helm"
    add_on_application = false
  }

  default_argocd_project = {
    namespace   = local.helm_config["namespace"]
    name        = "default"
    description = "Example Project"
    cluster_resource_whitelist = [
      {
        group = "*"
        kind  = "*"
      }
    ]
    namespace_resource_blacklist = []
    namespace_resource_whitelist = []
    destinations = [
      {
        namespace = "*"
        server    = "https://kubernetes.default.svc"
      }
    ]

    source_repos = ["*"]
    roles        = []
    sync_windows = []
  }

  global_application_values = {
    region      = var.addon_context.aws_region_name
    account     = var.addon_context.aws_caller_identity_account_id
    clusterName = var.addon_context.eks_cluster_id
  }

}
