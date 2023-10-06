# 231005-JC: variables tries to mirror aws-ia/terraform-aws-eks-blueprints-addon/blob/main/variables.tf
#            for type checking we can keep the current approach of specifying addon_defs as "any"
#            as otherwise changes in the addon module would require changes in the typings
#            (and, of course, it's more complex to have all the typings explicitly in each module)

# 231005-JC: TODO: consider adding support for additional charts (sync, notification, multi-tenancy)

variable "create" {
  type        = bool
  default     = true
}

variable "create_kubernetes_resources" {
  type        = bool
  default     = true
}

variable "addon_defs" {
  type        = any
  default     = {}

  # type = object({
  #
  #   ################################################################################
  #   # Helm Release
  #   ################################################################################
  #
  #   create_release = optional(bool)
  #   name = optional(string)
  #   description = optional(string)
  #   namespace = optional(string)
  #   create_namespace = optional(bool)
  #   chart = optional(string)
  #   chart_version = optional(string)
  #   repository = optional(string)
  #   values = optional(list(string))
  #   timeout = optional(number)
  #   repository_key_file = optional(string)
  #   repository_cert_file = optional(string)
  #   repository_ca_file = optional(string)
  #   repository_username = optional(string)
  #   repository_password = optional(string)
  #   devel = optional(bool)
  #   verify = optional(bool)
  #   keyring = optional(string)
  #   disable_webhooks = optional(bool)
  #   reuse_values = optional(bool)
  #   reset_values = optional(bool)
  #   force_update = optional(bool)
  #   recreate_pods = optional(bool)
  #   cleanup_on_fail = optional(bool)
  #   max_history = optional(number)
  #   atomic = optional(bool)
  #   skip_crds = optional(bool)
  #   render_subchart_notes = optional(bool)
  #   disable_openapi_validation = optional(bool)
  #   wait = optional(bool)
  #   wait_for_jobs = optional(bool)
  #   dependency_update = optional(bool)
  #   replace = optional(bool)
  #   lint = optional(bool)
  #   postrender = optional(any)
  #   set = optional(any)
  #   set_sensitive = optional(any)
  #   set_irsa_names = optional(list(string))
  #
  #   ################################################################################
  #   # IAM Role for Service Account(s) (IRSA)
  #   ################################################################################
  #
  #   create_role = optional(bool)
  #   role_name = optional(string)
  #   role_name_use_prefix = optional(bool)
  #   role_path = optional(string)
  #   role_permissions_boundary_arn = optional(string)
  #   role_description = optional(string)
  #   role_policies = optional(map(string))
  #   oidc_providers = optional(any)
  #   max_session_duration = optional(number)
  #   assume_role_condition_test = optional(string)
  #   allow_self_assume_role = optional(bool)
  #
  #   ################################################################################
  #   # IAM Policy
  #   ################################################################################
  #
  #   create_policy = optional(bool)
  #   source_policy_documents = optional(list(string))
  #   override_policy_documents = optional(list(string))
  #   policy_statements = optional(any)
  #   policy_name = optional(string)
  #   policy_name_use_prefix = optional(bool)
  #   policy_path = optional(string)
  #   policy_description = optional(string)
  # })
  # default = null
}

# # 231005-JC: TODO: decide whether to add control of each component installation, with cascading effect on IRSA...
# variable "components" {
#   description = "Default components to install (https://fluxcd.io/flux/installation/configuration/optional-components/)"
#   type = map(bool)
#   default = {
#     "source"       = true
#     "kustomize"    = true
#     "helm"         = true
#     "notification" = true
#     "image_reflector"  = true
#     "image_automation" = true
#   }
# }

# # TODO: consider whether to make this explicitly configurable (it can be overrideable via var.addon_defs.role_policies)
# variable "source_helmrepos_policy"

variable "source_buckets_s3_names" { # https://fluxcd.io/flux/components/source/buckets/#aws
  type        = list(string)
  default     = []
}

variable "kustomize_sops_kms_arns" { # https://fluxcd.io/flux/guides/mozilla-sops/#aws
  type        = list(string)
  default     = []
}

variable "tags" {
  type        = map(string)
  default     = {}
}
