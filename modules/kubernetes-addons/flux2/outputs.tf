

output "gitops_metadata" {
  description = "GitOps Bridge metadata (compatible with v1.9.x of parent module)"
  value =  {
    for k, v in merge(
      {
        iam_role_arn = module.addon.iam_role_arn
        namespace    = local.addon_namespace
      }, {
        for c, c_spec in local.local.controllers_irsa : "${c}_service_account" => (
          c_spec.sa_name
        ) if (c_spec.sa_name!=null)

      }
    ) : "flux2_${k}" => v if var.enable_this
  }
}

# # 231005-JC: TODO: outputs below are just conceptual exploration of how the support of multiple SAs and IAM roles in IRSA could work
# output "irsa_sa_names" {
#   description = "IRSA info for Gitops Bridge metadata and other uses (IRSA enabled SAs)"
#   value = {
#     for c, c_spec in local.local.controllers_irsa : c => {
#       namespace = local.addon_namespace
#       sa_name = c_spec.sa_name
#       allowed_in = [
#         # dict with role keys to output.irsa_role_names
#         "single"
#       ]
#     }
#   }
# }
# output "irsa_role_names" {
#   description = "IRSA info for Gitops Bridge metadata and other uses (IRSA roles)"
#   value = {
#     "single" = {
#       # even though we just have 1 element, it illustrates how to support N*M mapping that would be needed for flux2
#       iam_role_name = module.addon.iam_role_name
#       iam_role_arn = module.addon.iam_role_arn
#       allowed_sa = {
#         for c, c_spec in local.local.controllers_irsa : c => {
#           namespace = local.addon_namespace
#           sa_name = c_spec.sa_name
#         }
#       }
#     }
#   }
# }
