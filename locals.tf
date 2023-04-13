locals {
  # Configuration for managing add-ons via ArgoCD.
  argocd_addon_config = {
    awsEfsCsiDriver = var.enable_efs_csi_driver && var.enable_efs_csi_driver_gitops ? {
      enable             = true
      serviceAccountName = local.efs_csi_driver_service_account
    } : null
    awsFsxCsiDriver = var.enable_fsx_csi_driver && var.enable_fsx_csi_driver_gitops ? {
      enable             = true
      serviceAccountName = local.fsx_csi_driver_service_account
    } : null
    awsForFluentBit = var.enable_aws_for_fluentbit ? module.aws_for_fluent_bit[0].argocd_gitops_config : null
    awsLoadBalancerController = var.enable_aws_load_balancer_controller && var.enable_aws_load_balancer_controller_gitops ? {
      enable             = true
      serviceAccountName = local.aws_load_balancer_controller_service_account
    } : null
    awsNodeTerminationHandler = var.enable_aws_node_termination_handler && var.enable_aws_node_termination_handler_gitops ? {
      enable             = true
      serviceAccountName = local.aws_node_termination_handler_service_account
      queueURL           = module.aws_node_termination_handler_sqs.queue_url
    } : null
    certManager = var.enable_cert_manager && var.enable_cert_manager_gitops ? {
      enable             = true
      serviceAccountName = local.cert_manager_service_account
    } : null
    clusterAutoscaler = var.enable_cluster_autoscaler && var.enable_cluster_autoscaler_gitops ? {
      enable             = true
      serviceAccountName = local.cluster_autoscaler_service_account
    } : null
    secretsStoreCsiDriver = var.enable_secrets_store_csi_driver && var.enable_secrets_store_csi_driver_gitops ? {
      enable             = true
      serviceAccountName = local.secrets_store_csi_driver_service_account
    } : null
    grafana             = var.enable_grafana ? module.grafana[0].argocd_gitops_config : null
    ingressNginx        = var.enable_ingress_nginx ? module.ingress_nginx[0].argocd_gitops_config : null
    metricsServer       = var.enable_metrics_server ? module.metrics_server[0].argocd_gitops_config : null
    prometheus          = var.enable_prometheus ? module.prometheus[0].argocd_gitops_config : null
    vpa                 = var.enable_vpa ? module.vpa[0].argocd_gitops_config : null
    argoRollouts        = var.enable_argo_rollouts && var.enable_argo_rollouts_gitops ? { enable = true } : null
    argoWorkflows       = var.enable_argo_workflows && var.enable_argo_workflows_gitops ? { enable = true } : null
    karpenter           = var.enable_karpenter ? module.karpenter[0].argocd_gitops_config : null
    kubePrometheusStack = var.enable_kube_prometheus_stack ? module.kube_prometheus_stack[0].argocd_gitops_config : null
    awsCloudWatchMetrics = var.enable_cloudwatch_metrics && var.enable_cloudwatch_metrics_gitops ? {
      enable             = true
      serviceAccountName = local.cloudwatch_metrics_service_account
    } : null
    externalDns = var.enable_external_dns && var.enable_external_dns_gitops ? {
      enable             = true
      serviceAccountName = local.external_dns_service_account
    } : null
    externalSecrets = var.enable_external_secrets ? {
      enable             = true
      serviceAccountName = local.external_secrets_service_account
    } : null
    velero     = var.enable_velero ? module.velero[0].argocd_gitops_config : null
    promtail   = var.enable_promtail ? module.promtail[0].argocd_gitops_config : null
    gatekeeper = var.enable_gatekeeper ? module.gatekeeper[0].argocd_gitops_config : null
  }

  addon_context = {
    aws_caller_identity_account_id = local.account_id
    aws_caller_identity_arn        = data.aws_caller_identity.current.arn
    aws_partition_id               = local.partition
    aws_region_name                = local.region
    aws_eks_cluster_endpoint       = var.cluster_endpoint
    eks_cluster_id                 = var.cluster_name
    eks_oidc_issuer_url            = var.oidc_provider
    eks_oidc_provider_arn          = var.oidc_provider_arn
    tags                           = var.tags
    irsa_iam_role_path             = var.irsa_iam_role_path
    irsa_iam_permissions_boundary  = var.irsa_iam_permissions_boundary
  }
}
