# [TEMP] AWS EKS Blueprint Addon Terraform module

:warning: This is a temporary copy of `terraform-aws-eks-blueprints-addon` module while that module is undergoing the review process to be made public and published to the Terraform Registry. Once that module is published, this module will be removed and source paths updated to use the published module.


Terraform module which provisions an addon ([Helm release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)) and an [IAM role for service accounts (IRSA)](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html).

## Usage

### Create Addon (Helm Release) w/ IAM Role for Service Account (IRSA)

```hcl
module "eks_addon" {
  source = "aws-ia/eks-blueprints-addon/aws"

  chart            = "karpenter"
  chart_version    = "0.16.2"
  repository       = "https://charts.karpenter.sh/"
  description      = "Kubernetes Node Autoscaling: built for flexibility, performance, and simplicity"
  namespace        = "karpenter"
  create_namespace = true

  set = [
    {
      name  = "clusterName"
      value = "eks-blueprints-addon-example"
    },
    {
      name  = "clusterEndpoint"
      value = "https://EXAMPLED539D4633E53DE1B71EXAMPLE.gr7.us-west-2.eks.amazonaws.com"
    },
    {
      name  = "aws.defaultInstanceProfile"
      value = "arn:aws:iam::111111111111:instance-profile/KarpenterNodeInstanceProfile-complete"
    }
  ]

  set_irsa_name = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  # # Equivalent to the following but the ARN is only known internally to the module
  # set = [{
  #   name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  #   value = iam_role_arn.this[0].arn
  # }]

  # IAM role for service account (IRSA)
  create_role = true
  role_name   = "karpenter-controller"
  role_policy_arns = {
    karpenter = "arn:aws:iam::111111111111:policy/Karpenter_Controller_Policy-20221008165117447500000007"
  }

  oidc_providers = {
    this = {
      provider_arn = "oidc.eks.us-west-2.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE"
      # namespace is inherited from chart
      service_account = "karpenter"
    }
  }

  tags = {
    Environment = "dev"
  }
}
```

### Create Addon (Helm Release) Only

```hcl
module "eks_addon" {
  source = "aws-ia/eks-blueprints-addon/aws"

  chart         = "metrics-server"
  chart_version = "3.8.2"
  repository    = "https://kubernetes-sigs.github.io/metrics-server/"
  description   = "Metric server helm Chart deployment configuration"
  namespace     = "kube-system"

  values = [
    <<-EOT
      podDisruptionBudget:
        maxUnavailable: 1
      metrics:
        enabled: true
    EOT
  ]

  set = [
    {
      name  = "replicas"
      value = 3
    }
  ]
}
```

### Create IAM Role for Service Account (IRSA) Only

```hcl
module "eks_addon" {
  source = "aws-ia/eks-blueprints-addon/aws"

  # Disable helm release
  create_release = false

  # IAM role for service account (IRSA)
  create_role = true
  role_name   = "aws-vpc-cni-ipv4"
  role_policy_arns = {
    AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  }

  oidc_providers = {
    this = {
      provider_arn    = "oidc.eks.us-west-2.amazonaws.com/id/EXAMPLED539D4633E53DE1B71EXAMPLE"
      namespace       = "kube-system"
      service_account = "aws-node"
    }
  }

  tags = {
    Environment = "dev"
  }
}
```

## Examples

Examples codified under the [`examples`](https://github.com/aws-ia/terraform-aws-eks-blueprints-addon) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Complete](https://github.com/aws-ia/terraform-aws-eks-blueprints-addon/complete)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.9 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_self_assume_role"></a> [allow\_self\_assume\_role](#input\_allow\_self\_assume\_role) | Determines whether to allow the role to be [assume itself](https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/) | `bool` | `false` | no |
| <a name="input_assume_role_condition_test"></a> [assume\_role\_condition\_test](#input\_assume\_role\_condition\_test) | Name of the [IAM condition operator](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html) to evaluate when assuming the role | `string` | `"StringEquals"` | no |
| <a name="input_atomic"></a> [atomic](#input\_atomic) | If set, installation process purges chart on fail. The wait flag will be set automatically if atomic is used. Defaults to `false` | `bool` | `null` | no |
| <a name="input_chart"></a> [chart](#input\_chart) | Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if `repository` is specified | `string` | `""` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Specify the exact chart version to install. If this is not specified, the latest version is installed | `string` | `null` | no |
| <a name="input_cleanup_on_fail"></a> [cleanup\_on\_fail](#input\_cleanup\_on\_fail) | Allow deletion of new resources created in this upgrade when upgrade fails. Defaults to `false` | `bool` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. Defaults to `false` | `bool` | `null` | no |
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | Whether to create an IAM policy that is attached to the IAM role created | `bool` | `true` | no |
| <a name="input_create_release"></a> [create\_release](#input\_create\_release) | Determines whether the Helm release is created | `bool` | `true` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Determines whether to create an IAM role | `bool` | `false` | no |
| <a name="input_dependency_update"></a> [dependency\_update](#input\_dependency\_update) | Runs helm dependency update before installing the chart. Defaults to `false` | `bool` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Set release description attribute (visible in the history) | `string` | `null` | no |
| <a name="input_devel"></a> [devel](#input\_devel) | Use chart development versions, too. Equivalent to version '>0.0.0-0'. If version is set, this is ignored | `bool` | `null` | no |
| <a name="input_disable_openapi_validation"></a> [disable\_openapi\_validation](#input\_disable\_openapi\_validation) | If set, the installation process will not validate rendered templates against the Kubernetes OpenAPI Schema. Defaults to `false` | `bool` | `null` | no |
| <a name="input_disable_webhooks"></a> [disable\_webhooks](#input\_disable\_webhooks) | Prevent hooks from running. Defaults to `false` | `bool` | `null` | no |
| <a name="input_force_update"></a> [force\_update](#input\_force\_update) | Force resource update through delete/recreate if needed. Defaults to `false` | `bool` | `null` | no |
| <a name="input_keyring"></a> [keyring](#input\_keyring) | Location of public keys used for verification. Used only if verify is true. Defaults to `/.gnupg/pubring.gpg` in the location set by `home` | `string` | `null` | no |
| <a name="input_lint"></a> [lint](#input\_lint) | Run the helm chart linter during the plan. Defaults to `false` | `bool` | `null` | no |
| <a name="input_max_history"></a> [max\_history](#input\_max\_history) | Maximum number of release versions stored per release. Defaults to `0` (no limit) | `number` | `null` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Helm release | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the release into. Defaults to `default` | `string` | `null` | no |
| <a name="input_oidc_providers"></a> [oidc\_providers](#input\_oidc\_providers) | Map of OIDC providers where each provider map should contain the `provider_arn`, and `service_accounts` | `any` | `{}` | no |
| <a name="input_override_policy_documents"></a> [override\_policy\_documents](#input\_override\_policy\_documents) | List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank `sid`s will override statements with the same `sid` | `list(string)` | `[]` | no |
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | IAM policy description | `string` | `null` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name of IAM policy | `string` | `null` | no |
| <a name="input_policy_name_use_prefix"></a> [policy\_name\_use\_prefix](#input\_policy\_name\_use\_prefix) | Determines whether the IAM policy name (`policy_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | Path of IAM policy | `string` | `null` | no |
| <a name="input_policy_statements"></a> [policy\_statements](#input\_policy\_statements) | List of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) | `any` | `[]` | no |
| <a name="input_postrender"></a> [postrender](#input\_postrender) | Configure a command to run after helm renders the manifest which can alter the manifest contents | `any` | `{}` | no |
| <a name="input_recreate_pods"></a> [recreate\_pods](#input\_recreate\_pods) | Perform pods restart during upgrade/rollback. Defaults to `false` | `bool` | `null` | no |
| <a name="input_render_subchart_notes"></a> [render\_subchart\_notes](#input\_render\_subchart\_notes) | If set, render subchart notes along with the parent. Defaults to `true` | `bool` | `null` | no |
| <a name="input_replace"></a> [replace](#input\_replace) | Re-use the given name, only if that name is a deleted release which remains in the history. This is unsafe in production. Defaults to `false` | `bool` | `null` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart | `string` | `null` | no |
| <a name="input_repository_ca_file"></a> [repository\_ca\_file](#input\_repository\_ca\_file) | The Repositories CA File | `string` | `null` | no |
| <a name="input_repository_cert_file"></a> [repository\_cert\_file](#input\_repository\_cert\_file) | The repositories cert file | `string` | `null` | no |
| <a name="input_repository_key_file"></a> [repository\_key\_file](#input\_repository\_key\_file) | The repositories cert key file | `string` | `null` | no |
| <a name="input_repository_password"></a> [repository\_password](#input\_repository\_password) | Password for HTTP basic authentication against the repository | `string` | `null` | no |
| <a name="input_repository_username"></a> [repository\_username](#input\_repository\_username) | Username for HTTP basic authentication against the repository | `string` | `null` | no |
| <a name="input_reset_values"></a> [reset\_values](#input\_reset\_values) | When upgrading, reset the values to the ones built into the chart. Defaults to `false` | `bool` | `null` | no |
| <a name="input_reuse_values"></a> [reuse\_values](#input\_reuse\_values) | When upgrading, reuse the last release's values and merge in any overrides. If `reset_values` is specified, this is ignored. Defaults to `false` | `bool` | `null` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | IAM Role description | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of IAM role | `string` | `null` | no |
| <a name="input_role_name_use_prefix"></a> [role\_name\_use\_prefix](#input\_role\_name\_use\_prefix) | Determines whether the IAM role name (`role_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path of IAM role | `string` | `"/"` | no |
| <a name="input_role_permissions_boundary_arn"></a> [role\_permissions\_boundary\_arn](#input\_role\_permissions\_boundary\_arn) | Permissions boundary ARN to use for IAM role | `string` | `null` | no |
| <a name="input_role_policies"></a> [role\_policies](#input\_role\_policies) | Policies to attach to the IAM role in `{'static_name' = 'policy_arn'}` format | `map(string)` | `{}` | no |
| <a name="input_set"></a> [set](#input\_set) | Value block with custom values to be merged with the values yaml | `any` | `[]` | no |
| <a name="input_set_irsa_names"></a> [set\_irsa\_names](#input\_set\_irsa\_names) | Value annotations name where IRSA role ARN created by module will be assigned to the `value` | `list(string)` | `[]` | no |
| <a name="input_set_sensitive"></a> [set\_sensitive](#input\_set\_sensitive) | Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff | `any` | `[]` | no |
| <a name="input_skip_crds"></a> [skip\_crds](#input\_skip\_crds) | If set, no CRDs will be installed. By default, CRDs are installed if not already present. Defaults to `false` | `bool` | `null` | no |
| <a name="input_source_policy_documents"></a> [source\_policy\_documents](#input\_source\_policy\_documents) | List of IAM policy documents that are merged together into the exported document. Statements must have unique `sid`s | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks). Defaults to `300` seconds | `number` | `null` | no |
| <a name="input_values"></a> [values](#input\_values) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple `-f` options | `list(string)` | `null` | no |
| <a name="input_verify"></a> [verify](#input\_verify) | Verify the package before installing it. Helm uses a provenance file to verify the integrity of the chart; this must be hosted alongside the chart. For more information see the Helm Documentation. Defaults to `false` | `bool` | `null` | no |
| <a name="input_wait"></a> [wait](#input\_wait) | Will wait until all resources are in a ready state before marking the release as successful. It will wait for as long as `timeout`. Defaults to `true` | `bool` | `null` | no |
| <a name="input_wait_for_jobs"></a> [wait\_for\_jobs](#input\_wait\_for\_jobs) | If wait is enabled, will wait until all Jobs have been completed before marking the release as successful. It will wait for as long as `timeout`. Defaults to `false` | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_version"></a> [app\_version](#output\_app\_version) | The version number of the application being deployed |
| <a name="output_chart"></a> [chart](#output\_chart) | The name of the chart |
| <a name="output_iam_policy"></a> [iam\_policy](#output\_iam\_policy) | The policy document |
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The ARN assigned by AWS to this policy |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of IAM role |
| <a name="output_iam_role_path"></a> [iam\_role\_path](#output\_iam\_role\_path) | Path of IAM role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Unique ID of IAM role |
| <a name="output_name"></a> [name](#output\_name) | Name is the name of the release |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | Name of Kubernetes namespace |
| <a name="output_revision"></a> [revision](#output\_revision) | Version is an int32 which represents the version of the release |
| <a name="output_values"></a> [values](#output\_values) | The compounded values from `values` and `set*` attributes |
| <a name="output_version"></a> [version](#output\_version) | A SemVer 2 conformant version string of the chart |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Community

- [Code of conduct](.github/CODE_OF_CONDUCT.md)
- [Contributing](.github/CONTRIBUTING.md)
- [Security issue notifications](.github/CONTRIBUTING.md#security-issue-notifications)

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/aws-ia/terraform-aws-eks-blueprints-addon/blob/main/LICENSE).
