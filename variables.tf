variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.24`)"
  type        = string
}

variable "oidc_provider" {
  description = "The OpenID Connect identity provider (issuer URL without leading `https://`)"
  type        = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the cluster OIDC Provider"
  type        = string
}

################################################################################
# EKS Addons
################################################################################

variable "eks_addons" {
  description = "Map of EKS addon configurations to enable for the cluster. Addon name can be the map keys or set with `name`"
  type        = any
  default     = {}
}

variable "eks_addons_timeouts" {
  description = "Create, update, and delete timeout configurations for the EKS addons"
  type        = map(string)
  default     = {}
}

################################################################################
# AWS Node Termination Handler
################################################################################

variable "enable_aws_node_termination_handler" {
  description = "Enable AWS Node Termination Handler add-on"
  type        = bool
  default     = false
}

variable "enable_aws_node_termination_handler_gitops" {
  description = "Enable AWS Node Termination Handler using GitOps add-on"
  type        = bool
  default     = false
}

variable "aws_node_termination_handler" {
  description = "AWS Node Termination Handler addon configuration values"
  type        = any
  default     = {}
}

variable "aws_node_termination_handler_sqs" {
  description = "AWS Node Termination Handler SQS queue configuration values"
  type        = any
  default     = {}
}

variable "aws_node_termination_handler_asg_arns" {
  description = "List of Auto Scaling group ARNs that AWS Node Termination Handler will monitor for EC2 events"
  type        = list(string)
  default     = []
}

################################################################################
# ArgoCD
################################################################################

variable "enable_argocd" {
  description = "Enable Argo CD Kubernetes add-on"
  type        = bool
  default     = false
}

variable "argocd_helm_config" {
  description = "Argo CD Kubernetes add-on config"
  type        = any
  default     = {}
}

variable "argocd_projects" {
  description = "Argo CD Project config to bootstrap the cluster"
  type        = any
  default     = {}
}

variable "argocd_applications" {
  description = "Argo CD Applications config to bootstrap the cluster"
  type        = any
  default     = {}
}

variable "argocd_manage_add_ons" {
  description = "Enable managing add-on configuration via ArgoCD App of Apps"
  type        = bool
  default     = false
}

################################################################################
# Argo Workflows
################################################################################

variable "enable_argo_workflows" {
  description = "Enable Argo workflows add-on"
  type        = bool
  default     = false
}

variable "enable_argo_workflows_gitops" {
  description = "Enable Argo Workflows using GitOps add-on"
  type        = bool
  default     = false
}

variable "argo_workflows" {
  description = "Argo Workflows addon configuration values"
  type        = any
  default     = {}
}

################################################################################
# Argo Rollouts
################################################################################

variable "enable_argo_rollouts" {
  description = "Enable Argo Rollouts add-on"
  type        = bool
  default     = false
}

variable "enable_argo_rollouts_gitops" {
  description = "Enable Argo Rollouts using GitOps add-on"
  type        = bool
  default     = false
}

variable "argo_rollouts" {
  description = "Argo Rollouts addon configuration values"
  type        = any
  default     = {}
}

################################################################################
# Cert Manager
################################################################################

variable "enable_cert_manager" {
  description = "Enable cert-manager add-on"
  type        = bool
  default     = false
}

variable "enable_cert_manager_gitops" {
  description = "Enable cert-manager using GitOps add-on"
  type        = bool
  default     = false
}

variable "cert_manager" {
  description = "cert-manager addon configuration values"
  type        = any
  default     = {}
}

variable "cert_manager_route53_hosted_zone_arns" {
  description = "List of Route53 Hosted Zone ARNs that are used by cert-manager to create DNS records"
  type        = list(string)
  default     = ["arn:aws:route53:::hostedzone/*"]
}

################################################################################
# Cluster Autoscaler
################################################################################

variable "enable_cluster_autoscaler" {
  description = "Enable Cluster autoscaler add-on"
  type        = bool
  default     = false
}

variable "enable_cluster_autoscaler_gitops" {
  description = "Enable Cluster Autoscaler using GitOps add-on"
  type        = bool
  default     = false
}

variable "cluster_autoscaler" {
  description = "Cluster Autoscaler addon configuration values"
  type        = any
  default     = {}
}

################################################################################
# Cloudwatch Metrics
################################################################################

variable "enable_cloudwatch_metrics" {
  description = "Enable AWS Cloudwatch Metrics add-on for Container Insights"
  type        = bool
  default     = false
}

variable "enable_cloudwatch_metrics_gitops" {
  description = "Enable Cloudwatch Metrics using GitOps add-on"
  type        = bool
  default     = false
}

variable "cloudwatch_metrics" {
  description = "Cloudwatch Metrics addon configuration values"
  type        = any
  default     = {}
}

################################################################################
# External Secrets
################################################################################

variable "enable_external_secrets" {
  description = "Enable External Secrets operator add-on"
  type        = bool
  default     = false
}

variable "external_secrets" {
  description = "External Secrets addon configuration values"
  type        = any
  default     = {}
}

variable "external_secrets_ssm_parameter_arns" {
  description = "List of Systems Manager Parameter ARNs that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = ["arn:aws:ssm:*:*:parameter/*"]
}

variable "external_secrets_secrets_manager_arns" {
  description = "List of Secrets Manager ARNs that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = ["arn:aws:secretsmanager:*:*:secret:*"]
}

variable "external_secrets_kms_key_arns" {
  description = "List of KMS Key ARNs that are used by Secrets Manager that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = ["arn:aws:kms:*:*:key/*"]
}

################################################################################
# External DNS
################################################################################

variable "enable_external_dns" {
  description = "Enable external-dns operator add-on"
  type        = bool
  default     = false
}

variable "external_dns" {
  description = "external-dns addon configuration values"
  type        = any
  default     = {}
}

variable "enable_external_dns_gitops" {
  description = "Enable external-dns using GitOps add-on"
  type        = bool
  default     = false
}

variable "external_dns_route53_zone_arns" {
  description = "List of Route53 zones ARNs which external-dns will have access to create/manage records (if using Route53)"
  type        = list(string)
  default     = []
}

################################################################################
# Karpenter
################################################################################

variable "enable_karpenter" {
  description = "Enable Karpenter controller add-on"
  type        = bool
  default     = false
}

variable "karpenter" {
  description = "Karpenter addon configuration values"
  type        = any
  default     = {}
}

variable "enable_karpenter_gitops" {
  description = "Enable Karpenter using GitOps add-on"
  type        = bool
  default     = false
}

variable "karpenter_enable_spot_termination" {
  description = "Determines whether to enable native node termination handling"
  type        = bool
  default     = true
}

variable "karpenter_sqs" {
  description = "Karpenter SQS queue for native node termination handling configuration values"
  type        = any
  default     = {}
}

variable "karpenter_instance_profile" {
  description = "Karpenter instance profile configuration values"
  type        = any
  default     = {}
}

################################################################################
# Secrets Store CSI Driver
################################################################################

variable "enable_secrets_store_csi_driver" {
  description = "Enable CSI Secrets Store Provider"
  type        = bool
  default     = false
}

variable "enable_secrets_store_csi_driver_gitops" {
  description = "Enable CSI Secrets Store Provider GitOps add-on"
  type        = bool
  default     = false
}

variable "secrets_store_csi_driver" {
  description = "CSI Secrets Store Provider add-on configurations"
  type        = any
  default     = {}
}

################################################################################
# AWS for Fluentbit
################################################################################
variable "enable_aws_for_fluentbit" {
  description = "Enable AWS for FluentBit add-on"
  type        = bool
  default     = false
}

variable "enable_aws_for_fluentbit_gitops" {
  description = "Enable AWS for FluentBit add-on"
  type        = bool
  default     = false
}

variable "aws_for_fluentbit" {
  description = "AWS Fluentbit add-on configurations"
  type        = any
  default     = {}
}

variable "aws_for_fluentbit_cw_log_group" {
  description = "AWS Fluentbit CloudWatch Log Group configurations"
  type        = any
  default     = {}
}

################################################################################
# AWS Private CA Issuer
################################################################################

variable "enable_aws_privateca_issuer" {
  description = "Enable AWS PCA Issuer"
  type        = bool
  default     = false
}

variable "enable_aws_privateca_issuer_gitops" {
  description = "Enable AWS PCA Issuer GitOps add-on"
  type        = bool
  default     = false
}

variable "aws_privateca_issuer" {
  description = "AWS PCA Issuer add-on configurations"
  type        = any
  default     = {}
}

################################################################################
# Metrics Server
################################################################################

variable "enable_metrics_server" {
  description = "Enable metrics server add-on"
  type        = bool
  default     = false
}

variable "enable_metrics_server_gitops" {
  description = "Enable metrics GitOps server add-on"
  type        = bool
  default     = false
}

variable "metrics_server" {
  description = "Metrics Server add-on configurations"
  type        = any
  default     = {}
}

################################################################################
# Cluster Proportional Autoscaler
################################################################################

variable "enable_cluster_proportional_autoscaler" {
  description = "Enable Cluster Proportional Autoscaler"
  type        = bool
  default     = false
}

variable "enable_cluster_proportional_autoscaler_gitops" {
  description = "Enable Cluster Proportional Autoscaler GitOps add-on"
  type        = bool
  default     = false
}

variable "cluster_proportional_autoscaler" {
  description = "Cluster Proportional Autoscaler add-on configurations"
  type        = any
  default     = {}
}

################################################################################
# Ingress Nginx
################################################################################

variable "enable_ingress_nginx" {
  description = "Enable Ingress Nginx"
  type        = bool
  default     = false
}

variable "enable_ingress_nginx_gitops" {
  description = "Enable Ingress Nginx GitOps add-on"
  type        = bool
  default     = false
}

variable "ingress_nginx" {
  description = "Ingress Nginx add-on configurations"
  type        = any
  default     = {}
}

################################################################################
# Kube Prometheus Stack
################################################################################

variable "enable_kube_prometheus_stack" {
  description = "Enable Kube Prometheus Stack"
  type        = bool
  default     = false
}

variable "enable_kube_prometheus_stack_gitops" {
  description = "Enable Kube Prometheus Stack GitOps add-on"
  type        = bool
  default     = false
}

variable "kube_prometheus_stack" {
  description = "Kube Prometheus Stack add-on configurations"
  type        = any
  default     = {}
}

################################################################################
# Gatekeeper
################################################################################

variable "enable_gatekeeper" {
  description = "Enable Gatekeeper add-on"
  type        = bool
  default     = false
}

variable "enable_gatekeeper_gitops" {
  description = "Enable Gatekeeper GitOps add-on"
  type        = bool
  default     = false
}

variable "gatekeeper" {
  description = "Gatekeeper add-on configuration"
  type        = bool
  default     = false
}

################################################################################
# EFS CSI Driver
################################################################################

variable "enable_efs_csi_driver" {
  description = "Enable AWS EFS CSI Driver add-on"
  type        = bool
  default     = false
}

variable "enable_efs_csi_driver_gitops" {
  description = "Enable EFS CSI Driver using GitOps add-on"
  type        = bool
  default     = false
}

variable "efs_csi_driver" {
  description = "EFS CSI Driver addon configuration values"
  type        = any
  default     = {}
}

################################################################################
# FSx CSI Driver
################################################################################

variable "enable_fsx_csi_driver" {
  description = "Enable AWS FSX CSI Driver add-on"
  type        = bool
  default     = false
}

variable "enable_fsx_csi_driver_gitops" {
  description = "Enable FSX CSI Driver using GitOps add-on"
  type        = bool
  default     = false
}

variable "fsx_csi_driver" {
  description = "FSX CSI Driver addon configuration values"
  type        = any
  default     = {}
}

################################################################################
# AWS Load Balancer Controller
################################################################################
variable "enable_aws_load_balancer_controller" {
  description = "Enable AWS Load Balancer Controller add-on"
  type        = bool
  default     = false
}

variable "enable_aws_load_balancer_controller_gitops" {
  description = "AWS Load Balancer Controller using GitOps add-on"
  type        = bool
  default     = false
}

variable "aws_load_balancer_controller" {
  description = "AWS Loadbalancer Controller addon configuration values"
  type        = any
  default     = {}
}

################################################################################
# Vertical Pod Autoscaler
################################################################################
variable "enable_vpa" {
  description = "Enable Vertical Pod Autoscaler add-on"
  type        = bool
  default     = false
}

variable "enable_vpa_gitops" {
  description = "Vertical Pod Autoscaler using GitOps add-on"
  type        = bool
  default     = false
}

variable "vpa" {
  description = "Vertical Pod Autoscaler addon configuration values"
  type        = any
  default     = {}
}

#-------------------------------------------------------------------------------
variable "irsa_iam_role_path" {
  description = "IAM role path for IRSA roles"
  type        = string
  default     = "/"
}

variable "irsa_iam_permissions_boundary" {
  description = "IAM permissions boundary for IRSA roles"
  type        = string
  default     = ""
}

#-----------FARGATE FLUENT BIT-------------
variable "enable_fargate_fluentbit" {
  description = "Enable Fargate FluentBit add-on"
  type        = bool
  default     = false
}

variable "fargate_fluentbit_addon_config" {
  description = "Fargate fluentbit add-on config"
  type        = any
  default     = {}
}

#-----------Kubernetes Velero ADDON-------------
variable "enable_velero" {
  description = "Enable Kubernetes Dashboard add-on"
  type        = bool
  default     = false
}

variable "velero_helm_config" {
  description = "Kubernetes Velero Helm Chart config"
  type        = any
  default     = null
}

variable "velero_irsa_policies" {
  description = "IAM policy ARNs for velero IRSA"
  type        = list(string)
  default     = []
}

variable "velero_backup_s3_bucket" {
  description = "Bucket name for velero bucket"
  type        = string
  default     = ""
}

#-----------AWS CSI Secrets Store Provider-------------
variable "enable_secrets_store_csi_driver_provider_aws" {
  type        = bool
  default     = false
  description = "Enable AWS CSI Secrets Store Provider"
}

variable "csi_secrets_store_provider_aws_helm_config" {
  type        = any
  default     = null
  description = "CSI Secrets Store Provider AWS Helm Configurations"
}
