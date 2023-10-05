# https://fluxcd.io/flux/installation/configuration/workload-identity/#aws-iam-roles-for-service-accounts
#
# apiVersion: kustomize.config.k8s.io/v1beta1
# kind: Kustomization
# resources:
#   - gotk-components.yaml
#   - gotk-sync.yaml
# patches:
#   - patch: |
#       apiVersion: v1
#       kind: ServiceAccount
#       metadata:
#         name: controller
#         annotations:
#           eks.amazonaws.com/role-arn: <ECR ROLE ARN>
#     target:
#       kind: ServiceAccount
#       name: "(source-controller|image-reflector-controller)"
#   - patch: |
#       apiVersion: v1
#       kind: ServiceAccount
#       metadata:
#         name: controller
#         annotations:
#           eks.amazonaws.com/role-arn: <KMS ROLE ARN>
#     target:
#       kind: ServiceAccount
#       name: "kustomize-controller"


data "aws_iam_policy_document" "aws_efs_csi_driver" {
  count = var.enable_aws_efs_csi_driver ? 1 : 0

  source_policy_documents   = lookup(var.aws_efs_csi_driver, "source_policy_documents", [])
  override_policy_documents = lookup(var.aws_efs_csi_driver, "override_policy_documents", [])

  statement {
    sid       = "AllowDescribeAvailabilityZones"
    actions   = ["ec2:DescribeAvailabilityZones"]
    resources = ["*"]
  }

  statement {
    sid = "AllowDescribeFileSystems"
    actions = [
      "elasticfilesystem:DescribeAccessPoints",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeMountTargets"
    ]
    resources = flatten([
      local.efs_arns,
      local.efs_access_point_arns,
    ])
  }

  statement {
    actions = [
      "elasticfilesystem:CreateAccessPoint",
      "elasticfilesystem:TagResource",
    ]
    resources = local.efs_arns

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }

  statement {
    sid       = "AllowDeleteAccessPoint"
    actions   = ["elasticfilesystem:DeleteAccessPoint"]
    resources = local.efs_access_point_arns

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }

  statement {
    sid = "ClientReadWrite"
    actions = [
      "elasticfilesystem:ClientRootAccess",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:ClientMount",
    ]
    resources = local.efs_arns

    condition {
      test     = "Bool"
      variable = "elasticfilesystem:AccessedViaMountTarget"
      values   = ["true"]
    }
  }
}