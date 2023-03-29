locals {
  # Configuration for managing add-ons via ArgoCD.
  argocd_addon_config = {
    awsEfsCsiDriver = var.enable_efs_csi_driver && var.enable_efs_csi_driver_gitops ? {
      enable             = true
      serviceAccountName = local.efs_csi_driver_service_account
    } : null
    awsFSxCsiDriver           = var.enable_aws_fsx_csi_driver ? module.aws_fsx_csi_driver[0].argocd_gitops_config : null
    awsForFluentBit           = var.enable_aws_for_fluentbit ? module.aws_for_fluent_bit[0].argocd_gitops_config : null
    awsLoadBalancerController = var.enable_aws_load_balancer_controller ? module.aws_load_balancer_controller[0].argocd_gitops_config : null
    awsNodeTerminationHandler = var.enable_aws_node_termination_handler ? module.aws_node_termination_handler[0].argocd_gitops_config : null
    certManager               = var.enable_cert_manager ? module.cert_manager[0].argocd_gitops_config : null
    clusterAutoscaler         = var.enable_cluster_autoscaler ? module.cluster_autoscaler[0].argocd_gitops_config : null
    grafana                   = var.enable_grafana ? module.grafana[0].argocd_gitops_config : null
    ingressNginx              = var.enable_ingress_nginx ? module.ingress_nginx[0].argocd_gitops_config : null
    metricsServer             = var.enable_metrics_server ? module.metrics_server[0].argocd_gitops_config : null
    prometheus                = var.enable_prometheus ? module.prometheus[0].argocd_gitops_config : null
    vpa                       = var.enable_vpa ? module.vpa[0].argocd_gitops_config : null
    argoRollouts              = var.enable_argo_rollouts && var.enable_argo_rollouts_gitops ? { enable = true } : null
    argoWorkflows             = var.enable_argo_workflows && var.enable_argo_workflows_gitops ? { enable = true } : null
    karpenter                 = var.enable_karpenter ? module.karpenter[0].argocd_gitops_config : null
    kubePrometheusStack       = var.enable_kube_prometheus_stack ? module.kube_prometheus_stack[0].argocd_gitops_config : null
    awsCloudWatchMetrics = var.enable_cloudwatch_metrics && var.enable_cloudwatch_metrics_gitops ? {
      enable             = true
      serviceAccountName = local.cloudwatch_metrics_service_account
    } : null
    externalDns = var.enable_external_dns ? module.external_dns[0].argocd_gitops_config : null
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

  # For addons that pull images from a region-specific ECR container registry by default
  # for more information see: https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
  amazon_container_image_registry_uris = merge(
    {
      af-south-1     = "877085696533.dkr.ecr.af-south-1.amazonaws.com",
      ap-east-1      = "800184023465.dkr.ecr.ap-east-1.amazonaws.com",
      ap-northeast-1 = "602401143452.dkr.ecr.ap-northeast-1.amazonaws.com",
      ap-northeast-2 = "602401143452.dkr.ecr.ap-northeast-2.amazonaws.com",
      ap-northeast-3 = "602401143452.dkr.ecr.ap-northeast-3.amazonaws.com",
      ap-south-1     = "602401143452.dkr.ecr.ap-south-1.amazonaws.com",
      ap-southeast-1 = "602401143452.dkr.ecr.ap-southeast-1.amazonaws.com",
      ap-southeast-2 = "602401143452.dkr.ecr.ap-southeast-2.amazonaws.com",
      ap-southeast-3 = "296578399912.dkr.ecr.ap-southeast-3.amazonaws.com",
      ca-central-1   = "602401143452.dkr.ecr.ca-central-1.amazonaws.com",
      cn-north-1     = "918309763551.dkr.ecr.cn-north-1.amazonaws.com.cn",
      cn-northwest-1 = "961992271922.dkr.ecr.cn-northwest-1.amazonaws.com.cn",
      eu-central-1   = "602401143452.dkr.ecr.eu-central-1.amazonaws.com",
      eu-north-1     = "602401143452.dkr.ecr.eu-north-1.amazonaws.com",
      eu-south-1     = "590381155156.dkr.ecr.eu-south-1.amazonaws.com",
      eu-west-1      = "602401143452.dkr.ecr.eu-west-1.amazonaws.com",
      eu-west-2      = "602401143452.dkr.ecr.eu-west-2.amazonaws.com",
      eu-west-3      = "602401143452.dkr.ecr.eu-west-3.amazonaws.com",
      me-south-1     = "558608220178.dkr.ecr.me-south-1.amazonaws.com",
      me-central-1   = "759879836304.dkr.ecr.me-central-1.amazonaws.com",
      sa-east-1      = "602401143452.dkr.ecr.sa-east-1.amazonaws.com",
      us-east-1      = "602401143452.dkr.ecr.us-east-1.amazonaws.com",
      us-east-2      = "602401143452.dkr.ecr.us-east-2.amazonaws.com",
      us-gov-east-1  = "151742754352.dkr.ecr.us-gov-east-1.amazonaws.com",
      us-gov-west-1  = "013241004608.dkr.ecr.us-gov-west-1.amazonaws.com",
      us-west-1      = "602401143452.dkr.ecr.us-west-1.amazonaws.com",
      us-west-2      = "602401143452.dkr.ecr.us-west-2.amazonaws.com"
    },
    var.custom_image_registry_uri
  )
}
