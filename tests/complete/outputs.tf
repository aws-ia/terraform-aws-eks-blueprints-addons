output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${local.region} update-kubeconfig --name ${module.eks.cluster_name}"
}

output "aws_for_fluentbit_values" {
  value = module.eks_blueprints_addons.aws_for_fluentbit_values
}
output "aws_for_fluentbit_decoded_values" {
  value = module.eks_blueprints_addons.aws_for_fluentbit_decoded_values
}
output "addons" {
  value = module.eks_blueprints_addons
}