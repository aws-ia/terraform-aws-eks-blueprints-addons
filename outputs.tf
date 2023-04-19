output "eks_addons" {
  description = "Map of attributes for each EKS addons enabled"
  value       = aws_eks_addon.this
}

output "argocd" {
  description = "Map of attributes of the Helm release created"
  value       = try(module.argocd[0], null)
}

output "argocd_addon_config" {
  description = "ArgoCD addon config options"
  value       = local.argocd_addon_config
}

output "argo_rollouts" {
  description = "Map of attributes of the Helm release created"
  value       = module.argo_rollouts
}

output "argo_workflows" {
  description = "Map of attributes of the Helm release created"
  value       = module.argo_workflows
}

output "cloudwatch_metrics" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.cloudwatch_metrics
}

output "efs_csi_driver" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.efs_csi_driver
}

output "external_secrets" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.external_secrets
}

output "aws_for_fluentbit" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.aws_for_fluentbit
}

output "fsx_csi_driver" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.fsx_csi_driver
}

output "aws_load_balancer_controller" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.aws_load_balancer_controller
}

output "aws_node_termination_handler" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.aws_node_termination_handler
}

output "aws_privateca_issuer" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.aws_privateca_issuer
}

output "cert_manager" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.cert_manager
}

output "cluster_autoscaler" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.cluster_autoscaler
}

output "csi_secrets_store_provider_aws" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.csi_secrets_store_provider_aws
}

output "external_dns" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.external_dns
}

output "ingress_nginx" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.ingress_nginx
}

output "metrics_server" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.metrics_server
}

output "cluster_proportional_autoscaler" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.cluster_proportional_autoscaler
}

output "fargate_fluentbit" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.fargate_fluentbit[0], null)
}

output "gatekeeper" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.gatekeeper[0], null)
}

output "karpenter" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.karpenter
}

output "kube_prometheus_stack" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.kube_prometheus_stack
}

output "secrets_store_csi_driver" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.secrets_store_csi_driver
}

output "velero" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.velero[0], null)
}

output "vpa" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = module.vpa
}
