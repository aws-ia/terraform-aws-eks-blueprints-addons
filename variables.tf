variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "global_tolerations" {
  description = "A list of tolerations to apply to all supported Helm charts"
  type        = list(any)
  default     = []
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
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the cluster OIDC Provider"
  type        = string
}

variable "create_delay_duration" {
  description = "The duration to wait before creating resources"
  type        = string
  default     = "30s"
}

variable "create_delay_dependencies" {
  description = "Dependency attribute which must be resolved before starting the create_delay_duration"
  type        = list(string)
  default     = []
}

variable "enable_eks_fargate" {
  description = "Identifies whether or not respective addons should be modified to support deployment on EKS Fargate"
  type        = bool
  default     = false
}

################################################################################
# Argo Ecosystem
################################################################################

variable "enable_argo_rollouts" {
  description = "Enable Argo Rollouts add-on"
  type        = bool
  default     = false
}

variable "argo_rollouts" {
  description = "Argo Rollouts add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_argo_workflows" {
  description = "Enable Argo workflows add-on"
  type        = bool
  default     = false
}

variable "argo_workflows" {
  description = "Argo Workflows add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_argocd" {
  description = "Enable Argo CD Kubernetes add-on"
  type        = bool
  default     = false
}

variable "argocd" {
  description = "ArgoCD add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_argo_image_updater" {
  description = "Enable Argo Image Updater add-on"
  type        = bool
  default     = false
}

variable "argo_image_updater" {
  description = "Argo Image Updater add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_argo_events" {
  description = "Enable Argo Events add-on"
  type        = bool
  default     = false
}

variable "argo_events" {
  description = "Argo Events add-on configuration values"
  type        = any
  default     = {}
}

################################################################################
# AWS Add-ons
################################################################################

variable "enable_aws_cloudwatch_metrics" {
  description = "Enable AWS Cloudwatch Metrics add-on"
  type        = bool
  default     = false
}

variable "aws_cloudwatch_metrics" {
  description = "Cloudwatch Metrics add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_aws_efs_csi_driver" {
  description = "Enable AWS EFS CSI Driver add-on"
  type        = bool
  default     = false
}

variable "aws_efs_csi_driver" {
  description = "EFS CSI Driver add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_aws_for_fluentbit" {
  description = "Enable AWS for FluentBit add-on"
  type        = bool
  default     = false
}

variable "aws_for_fluentbit" {
  description = "AWS Fluentbit add-on configurations"
  type        = any
  default     = {}
}

variable "enable_aws_fsx_csi_driver" {
  description = "Enable AWS FSX CSI Driver add-on"
  type        = bool
  default     = false
}

variable "aws_fsx_csi_driver" {
  description = "FSX CSI Driver add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_aws_load_balancer_controller" {
  description = "Enable AWS Load Balancer Controller add-on"
  type        = bool
  default     = false
}

variable "aws_load_balancer_controller" {
  description = "AWS Load Balancer Controller add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_aws_node_termination_handler" {
  description = "Enable AWS Node Termination Handler add-on"
  type        = bool
  default     = false
}

variable "aws_node_termination_handler" {
  description = "AWS Node Termination Handler add-on configuration values"
  type        = any
  default     = {}
}

################################################################################
# Other Add-ons
################################################################################

variable "enable_cert_manager" {
  description = "Enable cert-manager add-on"
  type        = bool
  default     = false
}

variable "cert_manager" {
  description = "cert-manager add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_cluster_autoscaler" {
  description = "Enable Cluster autoscaler add-on"
  type        = bool
  default     = false
}

variable "cluster_autoscaler" {
  description = "Cluster Autoscaler add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_external_dns" {
  description = "Enable external-dns operator add-on"
  type        = bool
  default     = false
}

variable "external_dns" {
  description = "external-dns add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_external_secrets" {
  description = "Enable External Secrets operator add-on"
  type        = bool
  default     = false
}

variable "external_secrets" {
  description = "External Secrets add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_ingress_nginx" {
  description = "Enable Ingress Nginx"
  type        = bool
  default     = false
}

variable "ingress_nginx" {
  description = "Ingress Nginx add-on configurations"
  type        = any
  default     = {}
}

variable "enable_karpenter" {
  description = "Enable Karpenter controller add-on"
  type        = bool
  default     = false
}

variable "karpenter" {
  description = "Karpenter add-on configuration values"
  type        = any
  default     = {}
}

variable "enable_kube_prometheus_stack" {
  description = "Enable Kube Prometheus Stack"
  type        = bool
  default     = false
}

variable "kube_prometheus_stack" {
  description = "Kube Prometheus Stack add-on configurations"
  type        = any
  default     = {}
}

variable "enable_metrics_server" {
  description = "Enable metrics server add-on"
  type        = bool
  default     = false
}

variable "metrics_server" {
  description = "Metrics Server add-on configurations"
  type        = any
  default     = {}
}

variable "enable_velero" {
  description = "Enable Velero add-on"
  type        = bool
  default     = false
}

variable "velero" {
  description = "Velero add-on configuration values"
  type        = any
  default     = {}
}

################################################################################
# General
################################################################################

variable "create_kubernetes_resources" {
  description = "Create Kubernetes resource with Helm or Kubernetes provider"
  type        = bool
  default     = true
}

variable "observability_tag" {
  description = "Tag to identify EKS Blueprints usage within observability tools"
  type        = string
  default     = "qs-1ubotj5kl"
}
