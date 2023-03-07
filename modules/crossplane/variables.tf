variable "helm_config" {
  description = "Helm config for Crossplane"
  type        = any
  default     = {}
}

variable "addon_context" {
  description = "Input configuration for the addon"
  type = object({
    aws_caller_identity_account_id = string
    aws_caller_identity_arn        = string
    aws_eks_cluster_endpoint       = string
    aws_partition_id               = string
    aws_region_name                = string
    eks_cluster_id                 = string
    eks_oidc_issuer_url            = string
    eks_oidc_provider_arn          = string
    tags                           = map(string)
    irsa_iam_role_path             = string
    irsa_iam_permissions_boundary  = string
  })
}

variable "aws_provider" {
  description = "AWS Provider config for Crossplane"
  type        = any
}

variable "upbound_aws_provider" {
  description = "Upbound AWS Provider config for Crossplane"
  type        = any
}

variable "kubernetes_provider" {
  description = "Kubernetes Provider config for Crossplane"
  type        = any
}

variable "helm_provider" {
  description = "Helm Provider config for Crossplane"
  type        = any
}

variable "jet_aws_provider" {
  description = "AWS Provider Jet AWS config for Crossplane [Deprecated]"
  type = object({
    enable                   = bool
    provider_aws_version     = string
    additional_irsa_policies = list(string)
  })
}
