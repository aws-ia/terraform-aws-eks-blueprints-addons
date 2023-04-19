# EKS Blueprints Addons Terraform Module

### 🚧 Currently under development 🚧

See [here](https://github.com/aws-ia/terraform-aws-eks-blueprints/issues/1421) for more details on the changes to EKS Blueprints. While we work on incorprating the changes requested by users, we want to avoid unecessary disruptive changes. Therefore, we are working to incorporate as many changes as possible into the release of this module so that users only need to make this change once. Please feel free to try out the module as we develop it and leave any feedback, comments, requests. We look forward to providing an improved experience very soon! Thank you for your patience for for using EKS Blueprints!

Please note: not all addons will be supported as they are today in the main EKS Blueprints repository. We will have guidance and documentation that explains the changes, how to migrate/upgrade, and demonstrates the different options for addons that are no longer natively supported in this project.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_argo_rollouts"></a> [argo\_rollouts](#module\_argo\_rollouts) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_argo_workflows"></a> [argo\_workflows](#module\_argo\_workflows) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_argocd"></a> [argocd](#module\_argocd) | ./modules/argocd | n/a |
| <a name="module_aws_for_fluentbit"></a> [aws\_for\_fluentbit](#module\_aws\_for\_fluentbit) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_aws_load_balancer_controller"></a> [aws\_load\_balancer\_controller](#module\_aws\_load\_balancer\_controller) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_aws_node_termination_handler"></a> [aws\_node\_termination\_handler](#module\_aws\_node\_termination\_handler) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_aws_node_termination_handler_sqs"></a> [aws\_node\_termination\_handler\_sqs](#module\_aws\_node\_termination\_handler\_sqs) | terraform-aws-modules/sqs/aws | 4.0.1 |
| <a name="module_aws_privateca_issuer"></a> [aws\_privateca\_issuer](#module\_aws\_privateca\_issuer) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_cert_manager"></a> [cert\_manager](#module\_cert\_manager) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_cloudwatch_metrics"></a> [cloudwatch\_metrics](#module\_cloudwatch\_metrics) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_cluster_autoscaler"></a> [cluster\_autoscaler](#module\_cluster\_autoscaler) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_cluster_proportional_autoscaler"></a> [cluster\_proportional\_autoscaler](#module\_cluster\_proportional\_autoscaler) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_csi_secrets_store_provider_aws"></a> [csi\_secrets\_store\_provider\_aws](#module\_csi\_secrets\_store\_provider\_aws) | ./modules/csi-secrets-store-provider-aws | n/a |
| <a name="module_efs_csi_driver"></a> [efs\_csi\_driver](#module\_efs\_csi\_driver) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_external_dns"></a> [external\_dns](#module\_external\_dns) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_external_secrets"></a> [external\_secrets](#module\_external\_secrets) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_fargate_fluentbit"></a> [fargate\_fluentbit](#module\_fargate\_fluentbit) | ./modules/fargate-fluentbit | n/a |
| <a name="module_fsx_csi_driver"></a> [fsx\_csi\_driver](#module\_fsx\_csi\_driver) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_gatekeeper"></a> [gatekeeper](#module\_gatekeeper) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_ingress_nginx"></a> [ingress\_nginx](#module\_ingress\_nginx) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_karpenter"></a> [karpenter](#module\_karpenter) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_karpenter_sqs"></a> [karpenter\_sqs](#module\_karpenter\_sqs) | terraform-aws-modules/sqs/aws | 4.0.1 |
| <a name="module_kube_prometheus_stack"></a> [kube\_prometheus\_stack](#module\_kube\_prometheus\_stack) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_metrics_server"></a> [metrics\_server](#module\_metrics\_server) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_secrets_store_csi_driver"></a> [secrets\_store\_csi\_driver](#module\_secrets\_store\_csi\_driver) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_velero"></a> [velero](#module\_velero) | ./modules/velero | n/a |
| <a name="module_vpa"></a> [vpa](#module\_vpa) | ./modules/eks-blueprints-addon | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group_tag.aws_node_termination_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group_tag) | resource |
| [aws_autoscaling_lifecycle_hook.aws_node_termination_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_lifecycle_hook) | resource |
| [aws_cloudwatch_event_rule.aws_node_termination_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.aws_node_termination_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.aws_for_fluentbit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_eks_addon.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_iam_instance_profile.karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_addon_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_addon_version) | data source |
| [aws_iam_policy_document.aws_for_fluentbit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_node_termination_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_privateca_issuer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cert_manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.efs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.fsx_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argo_rollouts"></a> [argo\_rollouts](#input\_argo\_rollouts) | Argo Rollouts addon configuration values | `any` | `{}` | no |
| <a name="input_argo_workflows"></a> [argo\_workflows](#input\_argo\_workflows) | Argo Workflows addon configuration values | `any` | `{}` | no |
| <a name="input_argocd_applications"></a> [argocd\_applications](#input\_argocd\_applications) | Argo CD Applications config to bootstrap the cluster | `any` | `{}` | no |
| <a name="input_argocd_helm_config"></a> [argocd\_helm\_config](#input\_argocd\_helm\_config) | Argo CD Kubernetes add-on config | `any` | `{}` | no |
| <a name="input_argocd_manage_add_ons"></a> [argocd\_manage\_add\_ons](#input\_argocd\_manage\_add\_ons) | Enable managing add-on configuration via ArgoCD App of Apps | `bool` | `false` | no |
| <a name="input_argocd_projects"></a> [argocd\_projects](#input\_argocd\_projects) | Argo CD Project config to bootstrap the cluster | `any` | `{}` | no |
| <a name="input_aws_for_fluentbit"></a> [aws\_for\_fluentbit](#input\_aws\_for\_fluentbit) | AWS Fluentbit add-on configurations | `any` | `{}` | no |
| <a name="input_aws_for_fluentbit_cw_log_group"></a> [aws\_for\_fluentbit\_cw\_log\_group](#input\_aws\_for\_fluentbit\_cw\_log\_group) | AWS Fluentbit CloudWatch Log Group configurations | `any` | `{}` | no |
| <a name="input_aws_load_balancer_controller"></a> [aws\_load\_balancer\_controller](#input\_aws\_load\_balancer\_controller) | AWS Loadbalancer Controller addon configuration values | `any` | `{}` | no |
| <a name="input_aws_node_termination_handler"></a> [aws\_node\_termination\_handler](#input\_aws\_node\_termination\_handler) | AWS Node Termination Handler addon configuration values | `any` | `{}` | no |
| <a name="input_aws_node_termination_handler_asg_arns"></a> [aws\_node\_termination\_handler\_asg\_arns](#input\_aws\_node\_termination\_handler\_asg\_arns) | List of Auto Scaling group ARNs that AWS Node Termination Handler will monitor for EC2 events | `list(string)` | `[]` | no |
| <a name="input_aws_node_termination_handler_sqs"></a> [aws\_node\_termination\_handler\_sqs](#input\_aws\_node\_termination\_handler\_sqs) | AWS Node Termination Handler SQS queue configuration values | `any` | `{}` | no |
| <a name="input_aws_privateca_issuer"></a> [aws\_privateca\_issuer](#input\_aws\_privateca\_issuer) | AWS PCA Issuer add-on configurations | `any` | `{}` | no |
| <a name="input_cert_manager"></a> [cert\_manager](#input\_cert\_manager) | cert-manager addon configuration values | `any` | `{}` | no |
| <a name="input_cert_manager_route53_hosted_zone_arns"></a> [cert\_manager\_route53\_hosted\_zone\_arns](#input\_cert\_manager\_route53\_hosted\_zone\_arns) | List of Route53 Hosted Zone ARNs that are used by cert-manager to create DNS records | `list(string)` | <pre>[<br>  "arn:aws:route53:::hostedzone/*"<br>]</pre> | no |
| <a name="input_cloudwatch_metrics"></a> [cloudwatch\_metrics](#input\_cloudwatch\_metrics) | Cloudwatch Metrics addon configuration values | `any` | `{}` | no |
| <a name="input_cluster_autoscaler"></a> [cluster\_autoscaler](#input\_cluster\_autoscaler) | Cluster Autoscaler addon configuration values | `any` | `{}` | no |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | Endpoint for your Kubernetes API server | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_cluster_proportional_autoscaler"></a> [cluster\_proportional\_autoscaler](#input\_cluster\_proportional\_autoscaler) | Cluster Proportional Autoscaler add-on configurations | `any` | `{}` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.24`) | `string` | n/a | yes |
| <a name="input_csi_secrets_store_provider_aws_helm_config"></a> [csi\_secrets\_store\_provider\_aws\_helm\_config](#input\_csi\_secrets\_store\_provider\_aws\_helm\_config) | CSI Secrets Store Provider AWS Helm Configurations | `any` | `null` | no |
| <a name="input_efs_csi_driver"></a> [efs\_csi\_driver](#input\_efs\_csi\_driver) | EFS CSI Driver addon configuration values | `any` | `{}` | no |
| <a name="input_eks_addons"></a> [eks\_addons](#input\_eks\_addons) | Map of EKS addon configurations to enable for the cluster. Addon name can be the map keys or set with `name` | `any` | `{}` | no |
| <a name="input_eks_addons_timeouts"></a> [eks\_addons\_timeouts](#input\_eks\_addons\_timeouts) | Create, update, and delete timeout configurations for the EKS addons | `map(string)` | `{}` | no |
| <a name="input_enable_argo_rollouts"></a> [enable\_argo\_rollouts](#input\_enable\_argo\_rollouts) | Enable Argo Rollouts add-on | `bool` | `false` | no |
| <a name="input_enable_argo_rollouts_gitops"></a> [enable\_argo\_rollouts\_gitops](#input\_enable\_argo\_rollouts\_gitops) | Enable Argo Rollouts using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_argo_workflows"></a> [enable\_argo\_workflows](#input\_enable\_argo\_workflows) | Enable Argo workflows add-on | `bool` | `false` | no |
| <a name="input_enable_argo_workflows_gitops"></a> [enable\_argo\_workflows\_gitops](#input\_enable\_argo\_workflows\_gitops) | Enable Argo Workflows using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_argocd"></a> [enable\_argocd](#input\_enable\_argocd) | Enable Argo CD Kubernetes add-on | `bool` | `false` | no |
| <a name="input_enable_aws_for_fluentbit"></a> [enable\_aws\_for\_fluentbit](#input\_enable\_aws\_for\_fluentbit) | Enable AWS for FluentBit add-on | `bool` | `false` | no |
| <a name="input_enable_aws_for_fluentbit_gitops"></a> [enable\_aws\_for\_fluentbit\_gitops](#input\_enable\_aws\_for\_fluentbit\_gitops) | Enable AWS for FluentBit add-on | `bool` | `false` | no |
| <a name="input_enable_aws_load_balancer_controller"></a> [enable\_aws\_load\_balancer\_controller](#input\_enable\_aws\_load\_balancer\_controller) | Enable AWS Load Balancer Controller add-on | `bool` | `false` | no |
| <a name="input_enable_aws_load_balancer_controller_gitops"></a> [enable\_aws\_load\_balancer\_controller\_gitops](#input\_enable\_aws\_load\_balancer\_controller\_gitops) | AWS Load Balancer Controller using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_aws_node_termination_handler"></a> [enable\_aws\_node\_termination\_handler](#input\_enable\_aws\_node\_termination\_handler) | Enable AWS Node Termination Handler add-on | `bool` | `false` | no |
| <a name="input_enable_aws_node_termination_handler_gitops"></a> [enable\_aws\_node\_termination\_handler\_gitops](#input\_enable\_aws\_node\_termination\_handler\_gitops) | Enable AWS Node Termination Handler using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_aws_privateca_issuer"></a> [enable\_aws\_privateca\_issuer](#input\_enable\_aws\_privateca\_issuer) | Enable AWS PCA Issuer | `bool` | `false` | no |
| <a name="input_enable_aws_privateca_issuer_gitops"></a> [enable\_aws\_privateca\_issuer\_gitops](#input\_enable\_aws\_privateca\_issuer\_gitops) | Enable AWS PCA Issuer GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_cert_manager"></a> [enable\_cert\_manager](#input\_enable\_cert\_manager) | Enable cert-manager add-on | `bool` | `false` | no |
| <a name="input_enable_cert_manager_gitops"></a> [enable\_cert\_manager\_gitops](#input\_enable\_cert\_manager\_gitops) | Enable cert-manager using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_cloudwatch_metrics"></a> [enable\_cloudwatch\_metrics](#input\_enable\_cloudwatch\_metrics) | Enable AWS Cloudwatch Metrics add-on for Container Insights | `bool` | `false` | no |
| <a name="input_enable_cloudwatch_metrics_gitops"></a> [enable\_cloudwatch\_metrics\_gitops](#input\_enable\_cloudwatch\_metrics\_gitops) | Enable Cloudwatch Metrics using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_cluster_autoscaler"></a> [enable\_cluster\_autoscaler](#input\_enable\_cluster\_autoscaler) | Enable Cluster autoscaler add-on | `bool` | `false` | no |
| <a name="input_enable_cluster_autoscaler_gitops"></a> [enable\_cluster\_autoscaler\_gitops](#input\_enable\_cluster\_autoscaler\_gitops) | Enable Cluster Autoscaler using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_cluster_proportional_autoscaler"></a> [enable\_cluster\_proportional\_autoscaler](#input\_enable\_cluster\_proportional\_autoscaler) | Enable Cluster Proportional Autoscaler | `bool` | `false` | no |
| <a name="input_enable_cluster_proportional_autoscaler_gitops"></a> [enable\_cluster\_proportional\_autoscaler\_gitops](#input\_enable\_cluster\_proportional\_autoscaler\_gitops) | Enable Cluster Proportional Autoscaler GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_efs_csi_driver"></a> [enable\_efs\_csi\_driver](#input\_enable\_efs\_csi\_driver) | Enable AWS EFS CSI Driver add-on | `bool` | `false` | no |
| <a name="input_enable_efs_csi_driver_gitops"></a> [enable\_efs\_csi\_driver\_gitops](#input\_enable\_efs\_csi\_driver\_gitops) | Enable EFS CSI Driver using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_external_dns"></a> [enable\_external\_dns](#input\_enable\_external\_dns) | Enable external-dns operator add-on | `bool` | `false` | no |
| <a name="input_enable_external_dns_gitops"></a> [enable\_external\_dns\_gitops](#input\_enable\_external\_dns\_gitops) | Enable external-dns using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_external_secrets"></a> [enable\_external\_secrets](#input\_enable\_external\_secrets) | Enable External Secrets operator add-on | `bool` | `false` | no |
| <a name="input_enable_fargate_fluentbit"></a> [enable\_fargate\_fluentbit](#input\_enable\_fargate\_fluentbit) | Enable Fargate FluentBit add-on | `bool` | `false` | no |
| <a name="input_enable_fsx_csi_driver"></a> [enable\_fsx\_csi\_driver](#input\_enable\_fsx\_csi\_driver) | Enable AWS FSX CSI Driver add-on | `bool` | `false` | no |
| <a name="input_enable_fsx_csi_driver_gitops"></a> [enable\_fsx\_csi\_driver\_gitops](#input\_enable\_fsx\_csi\_driver\_gitops) | Enable FSX CSI Driver using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_gatekeeper"></a> [enable\_gatekeeper](#input\_enable\_gatekeeper) | Enable Gatekeeper add-on | `bool` | `false` | no |
| <a name="input_enable_gatekeeper_gitops"></a> [enable\_gatekeeper\_gitops](#input\_enable\_gatekeeper\_gitops) | Enable Gatekeeper GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_ingress_nginx"></a> [enable\_ingress\_nginx](#input\_enable\_ingress\_nginx) | Enable Ingress Nginx | `bool` | `false` | no |
| <a name="input_enable_ingress_nginx_gitops"></a> [enable\_ingress\_nginx\_gitops](#input\_enable\_ingress\_nginx\_gitops) | Enable Ingress Nginx GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_karpenter"></a> [enable\_karpenter](#input\_enable\_karpenter) | Enable Karpenter controller add-on | `bool` | `false` | no |
| <a name="input_enable_karpenter_gitops"></a> [enable\_karpenter\_gitops](#input\_enable\_karpenter\_gitops) | Enable Karpenter using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_kube_prometheus_stack"></a> [enable\_kube\_prometheus\_stack](#input\_enable\_kube\_prometheus\_stack) | Enable Kube Prometheus Stack | `bool` | `false` | no |
| <a name="input_enable_kube_prometheus_stack_gitops"></a> [enable\_kube\_prometheus\_stack\_gitops](#input\_enable\_kube\_prometheus\_stack\_gitops) | Enable Kube Prometheus Stack GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_metrics_server"></a> [enable\_metrics\_server](#input\_enable\_metrics\_server) | Enable metrics server add-on | `bool` | `false` | no |
| <a name="input_enable_metrics_server_gitops"></a> [enable\_metrics\_server\_gitops](#input\_enable\_metrics\_server\_gitops) | Enable metrics GitOps server add-on | `bool` | `false` | no |
| <a name="input_enable_secrets_store_csi_driver"></a> [enable\_secrets\_store\_csi\_driver](#input\_enable\_secrets\_store\_csi\_driver) | Enable CSI Secrets Store Provider | `bool` | `false` | no |
| <a name="input_enable_secrets_store_csi_driver_gitops"></a> [enable\_secrets\_store\_csi\_driver\_gitops](#input\_enable\_secrets\_store\_csi\_driver\_gitops) | Enable CSI Secrets Store Provider GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_secrets_store_csi_driver_provider_aws"></a> [enable\_secrets\_store\_csi\_driver\_provider\_aws](#input\_enable\_secrets\_store\_csi\_driver\_provider\_aws) | Enable AWS CSI Secrets Store Provider | `bool` | `false` | no |
| <a name="input_enable_velero"></a> [enable\_velero](#input\_enable\_velero) | Enable Kubernetes Dashboard add-on | `bool` | `false` | no |
| <a name="input_enable_vpa"></a> [enable\_vpa](#input\_enable\_vpa) | Enable Vertical Pod Autoscaler add-on | `bool` | `false` | no |
| <a name="input_enable_vpa_gitops"></a> [enable\_vpa\_gitops](#input\_enable\_vpa\_gitops) | Vertical Pod Autoscaler using GitOps add-on | `bool` | `false` | no |
| <a name="input_external_dns"></a> [external\_dns](#input\_external\_dns) | external-dns addon configuration values | `any` | `{}` | no |
| <a name="input_external_dns_route53_zone_arns"></a> [external\_dns\_route53\_zone\_arns](#input\_external\_dns\_route53\_zone\_arns) | List of Route53 zones ARNs which external-dns will have access to create/manage records (if using Route53) | `list(string)` | `[]` | no |
| <a name="input_external_secrets"></a> [external\_secrets](#input\_external\_secrets) | External Secrets addon configuration values | `any` | `{}` | no |
| <a name="input_external_secrets_kms_key_arns"></a> [external\_secrets\_kms\_key\_arns](#input\_external\_secrets\_kms\_key\_arns) | List of KMS Key ARNs that are used by Secrets Manager that contain secrets to mount using External Secrets | `list(string)` | <pre>[<br>  "arn:aws:kms:*:*:key/*"<br>]</pre> | no |
| <a name="input_external_secrets_secrets_manager_arns"></a> [external\_secrets\_secrets\_manager\_arns](#input\_external\_secrets\_secrets\_manager\_arns) | List of Secrets Manager ARNs that contain secrets to mount using External Secrets | `list(string)` | <pre>[<br>  "arn:aws:secretsmanager:*:*:secret:*"<br>]</pre> | no |
| <a name="input_external_secrets_ssm_parameter_arns"></a> [external\_secrets\_ssm\_parameter\_arns](#input\_external\_secrets\_ssm\_parameter\_arns) | List of Systems Manager Parameter ARNs that contain secrets to mount using External Secrets | `list(string)` | <pre>[<br>  "arn:aws:ssm:*:*:parameter/*"<br>]</pre> | no |
| <a name="input_fargate_fluentbit_addon_config"></a> [fargate\_fluentbit\_addon\_config](#input\_fargate\_fluentbit\_addon\_config) | Fargate fluentbit add-on config | `any` | `{}` | no |
| <a name="input_fsx_csi_driver"></a> [fsx\_csi\_driver](#input\_fsx\_csi\_driver) | FSX CSI Driver addon configuration values | `any` | `{}` | no |
| <a name="input_gatekeeper"></a> [gatekeeper](#input\_gatekeeper) | Gatekeeper add-on configuration | `bool` | `false` | no |
| <a name="input_ingress_nginx"></a> [ingress\_nginx](#input\_ingress\_nginx) | Ingress Nginx add-on configurations | `any` | `{}` | no |
| <a name="input_irsa_iam_permissions_boundary"></a> [irsa\_iam\_permissions\_boundary](#input\_irsa\_iam\_permissions\_boundary) | IAM permissions boundary for IRSA roles | `string` | `""` | no |
| <a name="input_irsa_iam_role_path"></a> [irsa\_iam\_role\_path](#input\_irsa\_iam\_role\_path) | IAM role path for IRSA roles | `string` | `"/"` | no |
| <a name="input_karpenter"></a> [karpenter](#input\_karpenter) | Karpenter addon configuration values | `any` | `{}` | no |
| <a name="input_karpenter_enable_spot_termination"></a> [karpenter\_enable\_spot\_termination](#input\_karpenter\_enable\_spot\_termination) | Determines whether to enable native node termination handling | `bool` | `true` | no |
| <a name="input_karpenter_instance_profile"></a> [karpenter\_instance\_profile](#input\_karpenter\_instance\_profile) | Karpenter instance profile configuration values | `any` | `{}` | no |
| <a name="input_karpenter_sqs"></a> [karpenter\_sqs](#input\_karpenter\_sqs) | Karpenter SQS queue for native node termination handling configuration values | `any` | `{}` | no |
| <a name="input_kube_prometheus_stack"></a> [kube\_prometheus\_stack](#input\_kube\_prometheus\_stack) | Kube Prometheus Stack add-on configurations | `any` | `{}` | no |
| <a name="input_metrics_server"></a> [metrics\_server](#input\_metrics\_server) | Metrics Server add-on configurations | `any` | `{}` | no |
| <a name="input_oidc_provider"></a> [oidc\_provider](#input\_oidc\_provider) | The OpenID Connect identity provider (issuer URL without leading `https://`) | `string` | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | The ARN of the cluster OIDC Provider | `string` | n/a | yes |
| <a name="input_secrets_store_csi_driver"></a> [secrets\_store\_csi\_driver](#input\_secrets\_store\_csi\_driver) | CSI Secrets Store Provider add-on configurations | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_velero_backup_s3_bucket"></a> [velero\_backup\_s3\_bucket](#input\_velero\_backup\_s3\_bucket) | Bucket name for velero bucket | `string` | `""` | no |
| <a name="input_velero_helm_config"></a> [velero\_helm\_config](#input\_velero\_helm\_config) | Kubernetes Velero Helm Chart config | `any` | `null` | no |
| <a name="input_velero_irsa_policies"></a> [velero\_irsa\_policies](#input\_velero\_irsa\_policies) | IAM policy ARNs for velero IRSA | `list(string)` | `[]` | no |
| <a name="input_vpa"></a> [vpa](#input\_vpa) | Vertical Pod Autoscaler addon configuration values | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_argo_rollouts"></a> [argo\_rollouts](#output\_argo\_rollouts) | Map of attributes of the Helm release created |
| <a name="output_argo_workflows"></a> [argo\_workflows](#output\_argo\_workflows) | Map of attributes of the Helm release created |
| <a name="output_argocd"></a> [argocd](#output\_argocd) | Map of attributes of the Helm release created |
| <a name="output_argocd_addon_config"></a> [argocd\_addon\_config](#output\_argocd\_addon\_config) | ArgoCD addon config options |
| <a name="output_aws_for_fluentbit"></a> [aws\_for\_fluentbit](#output\_aws\_for\_fluentbit) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_load_balancer_controller"></a> [aws\_load\_balancer\_controller](#output\_aws\_load\_balancer\_controller) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_node_termination_handler"></a> [aws\_node\_termination\_handler](#output\_aws\_node\_termination\_handler) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_privateca_issuer"></a> [aws\_privateca\_issuer](#output\_aws\_privateca\_issuer) | Map of attributes of the Helm release and IRSA created |
| <a name="output_cert_manager"></a> [cert\_manager](#output\_cert\_manager) | Map of attributes of the Helm release and IRSA created |
| <a name="output_cloudwatch_metrics"></a> [cloudwatch\_metrics](#output\_cloudwatch\_metrics) | Map of attributes of the Helm release and IRSA created |
| <a name="output_cluster_autoscaler"></a> [cluster\_autoscaler](#output\_cluster\_autoscaler) | Map of attributes of the Helm release and IRSA created |
| <a name="output_cluster_proportional_autoscaler"></a> [cluster\_proportional\_autoscaler](#output\_cluster\_proportional\_autoscaler) | Map of attributes of the Helm release and IRSA created |
| <a name="output_csi_secrets_store_provider_aws"></a> [csi\_secrets\_store\_provider\_aws](#output\_csi\_secrets\_store\_provider\_aws) | Map of attributes of the Helm release and IRSA created |
| <a name="output_efs_csi_driver"></a> [efs\_csi\_driver](#output\_efs\_csi\_driver) | Map of attributes of the Helm release and IRSA created |
| <a name="output_eks_addons"></a> [eks\_addons](#output\_eks\_addons) | Map of attributes for each EKS addons enabled |
| <a name="output_external_dns"></a> [external\_dns](#output\_external\_dns) | Map of attributes of the Helm release and IRSA created |
| <a name="output_external_secrets"></a> [external\_secrets](#output\_external\_secrets) | Map of attributes of the Helm release and IRSA created |
| <a name="output_fargate_fluentbit"></a> [fargate\_fluentbit](#output\_fargate\_fluentbit) | Map of attributes of the Helm release and IRSA created |
| <a name="output_fsx_csi_driver"></a> [fsx\_csi\_driver](#output\_fsx\_csi\_driver) | Map of attributes of the Helm release and IRSA created |
| <a name="output_gatekeeper"></a> [gatekeeper](#output\_gatekeeper) | Map of attributes of the Helm release and IRSA created |
| <a name="output_ingress_nginx"></a> [ingress\_nginx](#output\_ingress\_nginx) | Map of attributes of the Helm release and IRSA created |
| <a name="output_karpenter"></a> [karpenter](#output\_karpenter) | Map of attributes of the Helm release and IRSA created |
| <a name="output_kube_prometheus_stack"></a> [kube\_prometheus\_stack](#output\_kube\_prometheus\_stack) | Map of attributes of the Helm release and IRSA created |
| <a name="output_metrics_server"></a> [metrics\_server](#output\_metrics\_server) | Map of attributes of the Helm release and IRSA created |
| <a name="output_secrets_store_csi_driver"></a> [secrets\_store\_csi\_driver](#output\_secrets\_store\_csi\_driver) | Map of attributes of the Helm release and IRSA created |
| <a name="output_velero"></a> [velero](#output\_velero) | Map of attributes of the Helm release and IRSA created |
| <a name="output_vpa"></a> [vpa](#output\_vpa) | Map of attributes of the Helm release and IRSA created |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
