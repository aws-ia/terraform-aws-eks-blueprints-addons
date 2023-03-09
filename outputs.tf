output "argocd" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.argocd[0], null)
}

output "argo_rollouts" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.argo_rollouts[0], null)
}

output "argo_workflows" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.argo_workflows[0], null)
}

output "aws_cloudwatch_metrics" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.aws_cloudwatch_metrics[0], null)
}

output "aws_coredns" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.aws_coredns[0], null)
}

output "aws_ebs_csi_driver" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.aws_ebs_csi_driver[0], null)
}

output "aws_efs_csi_driver" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.aws_efs_csi_driver[0], null)
}

output "aws_for_fluent_bit" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.aws_for_fluent_bit[0], null)
}

output "aws_fsx_csi_driver" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.aws_fsx_csi_driver[0], null)
}

output "aws_kube_proxy" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.aws_kube_proxy[0], null)
}

output "aws_load_balancer_controller" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.aws_load_balancer_controller[0], null)
}

output "aws_node_termination_handler" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.aws_node_termination_handler[0], null)
}

output "aws_privateca_issuer" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.aws_privateca_issuer[0], null)
}

output "aws_vpc_cni" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.aws_vpc_cni[0], null)
}

output "cert_manager" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.cert_manager[0], null)
}

output "cluster_autoscaler" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.cluster_autoscaler[0], null)
}

output "csi_secrets_store_provider_aws" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.csi_secrets_store_provider_aws[0], null)
}

output "external_dns" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.external_dns[0], null)
}

output "external_secrets" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.external_secrets[0], null)
}

output "fargate_fluentbit" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.fargate_fluentbit[0], null)
}

output "gatekeeper" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.gatekeeper[0], null)
}

output "grafana" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.grafana[0], null)
}

output "ingress_nginx" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.ingress_nginx[0], null)
}

output "karpenter" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.karpenter[0], null)
}

output "kube_prometheus_stack" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.kube_prometheus_stack[0], null)
}

output "metrics_server" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.metrics_server[0], null)
}

output "opentelemetry_operator" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.opentelemetry_operator[0], null)
}

output "prometheus" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.prometheus[0], null)
}

output "promtail" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.promtail[0], null)
}

output "secrets_store_csi_driver" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.secrets_store_csi_driver[0], null)
}

output "velero" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.velero[0], null)
}

output "vpa" {
  description = "Map of attributes of the Helm release and IRSA created"
  value       = try(module.vpa[0], null)
}
