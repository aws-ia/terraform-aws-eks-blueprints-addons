locals {
  name      = try(var.helm_config.name, "secrets-store-csi-driver-provider-aws")
  namespace = try(var.helm_config.namespace, "kube-system")
}

module "secrets_store_csi_driver" {
  source = "../secrets-store-csi-driver"

  addon_context = var.addon_context
}

resource "kubernetes_namespace_v1" "csi_secrets_store_provider_aws" {
  count = local.namespace == "kube-system" ? 0 : 1

  metadata {
    name = local.namespace
  }
}

module "helm_addon" {
  source = "../helm-addon"

  # https://github.com/aws/eks-charts/blob/master/stable/csi-secrets-store-provider-aws/Chart.yaml
  helm_config = merge(
    {
      name        = local.name
      chart       = local.name
      repository  = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
      version     = "0.3.1"
      namespace   = local.namespace
      description = "A Helm chart to install the Secrets Store CSI Driver and the AWS Key Management Service Provider inside a Kubernetes cluster."
    },
    var.helm_config
  )

  manage_via_gitops = var.manage_via_gitops
  addon_context     = var.addon_context

  depends_on = [
    kubernetes_namespace_v1.csi_secrets_store_provider_aws,
    module.secrets_store_csi_driver
  ]
}
