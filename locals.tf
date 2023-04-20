locals {
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
