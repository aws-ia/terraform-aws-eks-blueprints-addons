# https://fluxcd.io/flux/installation/configuration/workload-identity/#aws-iam-roles-for-service-accounts
# https://fluxcd.io/flux/security/contextual-authorization/
#   https://fluxcd.io/flux/components/source/ocirepositories/#aws
#   https://fluxcd.io/flux/components/source/buckets/#aws
#   https://fluxcd.io/flux/components/source/helmrepositories/#aws
#   https://fluxcd.io/flux/components/image/imagerepositories/#aws
#   https://fluxcd.io/flux/guides/mozilla-sops/#aws
#
# as of 2023-10-05, the following controllers are available:
# Supported	      Source Controller	              Bucket Repository Authentication	    AWS	Guide
# Supported	      Source Controller	              OCI Repository Authentication	        AWS	Guide
# Supported	      Image Reflector Controller      Container Registry Authentication	    AWS	Guide
# Supported	      Kustomize Controller            SOPS Integration with Cloud KMS	      AWS	Guide
# Supported	      Source Controller	              Helm OCI Repository Authentication	  AWS	Guide
# Not Supported	  Source Controller	              Git Repository Authentication (RO)	  AWS	fluxcd/source-controller#835
# Not Supported	  Image Automation Controller	    Git Repository Authentication (RW)	  AWS
#

data "aws_iam_policy_document" "flux2_all" {
  count = var.enable_flux2 ? 1 : 0

  source_policy_documents   = try(var.flux2.source_policy_documents, [])
  override_policy_documents = try(var.flux2.override_policy_documents, [])

  # https://fluxcd.io/flux/components/source/buckets/#aws
  statement {
    for_each = local.source_buckets_s3_names

    sid       = "AllowBucketS3_1"
    actions   = [
      "s3:GetObject"
    ]
    resources = ["arn:aws:s3:::${each.value}/*"]
  }

  # https://fluxcd.io/flux/components/source/buckets/#aws
  statement {
    for_each = local.source_buckets_s3_names

    sid       = "AllowBucketS3_2"
    actions = [
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::${each.value}"]
  }

  # https://fluxcd.io/flux/guides/mozilla-sops/#aws
  statement {
    for_each = local.kustomize_sops_kms_arns

    sid       = "AllowKMSDecrypt"
    actions   = [
      "kms:Decrypt",
      "kms:DescribeKey"
    ]
    resources = [each.value]
  }

}