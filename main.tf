data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "time_sleep" "dataplane" {
  create_duration = "10s"

  triggers = {
    data_plane_wait_arn = var.data_plane_wait_arn # this waits for the data plane to be ready
    eks_cluster_id      = var.eks_cluster_id      # this ties it to downstream resources
  }
}

data "aws_eks_cluster" "eks_cluster" {
  # this makes downstream resources wait for data plane to be ready
  name = time_sleep.dataplane.triggers["eks_cluster_id"]
}

#-----------------AWS Managed EKS Add-ons----------------------

module "aws_vpc_cni" {
  source = "./modules/aws-vpc-cni"

  count = var.enable_amazon_eks_vpc_cni ? 1 : 0

  enable_ipv6 = var.enable_ipv6
  addon_config = merge(
    {
      kubernetes_version = local.eks_cluster_version
    },
    var.amazon_eks_vpc_cni_config,
  )

  addon_context = local.addon_context
}

module "aws_coredns" {
  source = "./modules/aws-coredns"

  count = var.enable_amazon_eks_coredns || var.enable_self_managed_coredns ? 1 : 0

  addon_context = local.addon_context

  # Amazon EKS CoreDNS addon
  enable_amazon_eks_coredns = var.enable_amazon_eks_coredns
  addon_config = merge(
    {
      kubernetes_version = local.eks_cluster_version
    },
    var.amazon_eks_coredns_config,
  )

  # Self-managed CoreDNS addon via Helm chart
  enable_self_managed_coredns = var.enable_self_managed_coredns
  helm_config = merge(
    {
      kubernetes_version = local.eks_cluster_version
    },
    var.self_managed_coredns_helm_config,
    {
      # Putting after because we don't want users to overwrite this - internal use only
      image_registry = local.amazon_container_image_registry_uris[data.aws_region.current.name]
    }
  )

  # CoreDNS cluster proportioanl autoscaler
  enable_cluster_proportional_autoscaler      = var.enable_coredns_cluster_proportional_autoscaler
  cluster_proportional_autoscaler_helm_config = var.coredns_cluster_proportional_autoscaler_helm_config

  remove_default_coredns_deployment      = var.remove_default_coredns_deployment
  eks_cluster_certificate_authority_data = data.aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

module "aws_kube_proxy" {
  source = "./modules/aws-kube-proxy"

  count = var.enable_amazon_eks_kube_proxy ? 1 : 0

  addon_config = merge(
    {
      kubernetes_version = local.eks_cluster_version
    },
    var.amazon_eks_kube_proxy_config,
  )

  addon_context = local.addon_context
}

module "aws_ebs_csi_driver" {
  source = "./modules/aws-ebs-csi-driver"

  count = var.enable_amazon_eks_aws_ebs_csi_driver || var.enable_self_managed_aws_ebs_csi_driver ? 1 : 0

  # Amazon EKS aws-ebs-csi-driver addon
  enable_amazon_eks_aws_ebs_csi_driver = var.enable_amazon_eks_aws_ebs_csi_driver
  addon_config = merge(
    {
      kubernetes_version = local.eks_cluster_version
    },
    var.amazon_eks_aws_ebs_csi_driver_config,
  )

  addon_context = local.addon_context

  # Self-managed aws-ebs-csi-driver addon via Helm chart
  enable_self_managed_aws_ebs_csi_driver = var.enable_self_managed_aws_ebs_csi_driver
  helm_config = merge(
    {
      kubernetes_version = local.eks_cluster_version
    },
    var.self_managed_aws_ebs_csi_driver_helm_config,
  )
}

#-----------------Kubernetes Add-ons----------------------

module "argocd" {
  count         = var.enable_argocd ? 1 : 0
  source        = "./modules/argocd"
  helm_config   = var.argocd_helm_config
  applications  = var.argocd_applications
  addon_config  = { for k, v in local.argocd_addon_config : k => v if v != null }
  addon_context = local.addon_context
}

module "argo_rollouts" {
  count             = var.enable_argo_rollouts ? 1 : 0
  source            = "./modules/argo-rollouts"
  helm_config       = var.argo_rollouts_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}

module "argo_workflows" {
  count             = var.enable_argo_workflows ? 1 : 0
  source            = "./modules/argo-workflows"
  helm_config       = var.argo_workflows_helm_config
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
}

module "aws_efs_csi_driver" {
  count             = var.enable_aws_efs_csi_driver ? 1 : 0
  source            = "./modules/aws-efs-csi-driver"
  helm_config       = var.aws_efs_csi_driver_helm_config
  irsa_policies     = var.aws_efs_csi_driver_irsa_policies
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
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
  count                    = var.enable_aws_for_fluentbit ? 1 : 0
  source                   = "./modules/aws-for-fluentbit"
  helm_config              = var.aws_for_fluentbit_helm_config
  irsa_policies            = var.aws_for_fluentbit_irsa_policies
  create_cw_log_group      = var.aws_for_fluentbit_create_cw_log_group
  cw_log_group_name        = var.aws_for_fluentbit_cw_log_group_name
  cw_log_group_retention   = var.aws_for_fluentbit_cw_log_group_retention
  cw_log_group_kms_key_arn = var.aws_for_fluentbit_cw_log_group_kms_key_arn
  manage_via_gitops        = var.argocd_manage_add_ons
  addon_context            = local.addon_context
}

module "aws_cloudwatch_metrics" {
  count             = var.enable_aws_cloudwatch_metrics ? 1 : 0
  source            = "./modules/aws-cloudwatch-metrics"
  helm_config       = var.aws_cloudwatch_metrics_helm_config
  irsa_policies     = var.aws_cloudwatch_metrics_irsa_policies
  manage_via_gitops = var.argocd_manage_add_ons
  addon_context     = local.addon_context
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

  eks_cluster_version = local.eks_cluster_version
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

  domain_name       = var.eks_cluster_domain
  private_zone      = var.external_dns_private_zone
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
      kubernetes_version = var.eks_cluster_version
    },
    var.amazon_eks_adot_config,
  )

  # Self-managed OpenTelemetry Operator via Helm chart
  enable_opentelemetry_operator = var.enable_opentelemetry_operator
  helm_config                   = var.opentelemetry_operator_helm_config

  addon_context = local.addon_context
}

module "external_secrets" {
  source = "./modules/external-secrets"

  count = var.enable_external_secrets ? 1 : 0

  helm_config                           = var.external_secrets_helm_config
  manage_via_gitops                     = var.argocd_manage_add_ons
  addon_context                         = local.addon_context
  irsa_policies                         = var.external_secrets_irsa_policies
  external_secrets_ssm_parameter_arns   = var.external_secrets_ssm_parameter_arns
  external_secrets_secrets_manager_arns = var.external_secrets_secrets_manager_arns
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
