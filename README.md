# EKS Blueprints Addons Terraform Module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.8 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_argo_rollouts"></a> [argo\_rollouts](#module\_argo\_rollouts) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_argo_workflows"></a> [argo\_workflows](#module\_argo\_workflows) | ./modules/eks-blueprints-addon | n/a |
| <a name="module_argocd"></a> [argocd](#module\_argocd) | ./modules/argocd | n/a |
| <a name="module_aws_cloudwatch_metrics"></a> [aws\_cloudwatch\_metrics](#module\_aws\_cloudwatch\_metrics) | ./modules/aws-cloudwatch-metrics | n/a |
| <a name="module_aws_coredns"></a> [aws\_coredns](#module\_aws\_coredns) | ./modules/aws-coredns | n/a |
| <a name="module_aws_ebs_csi_driver"></a> [aws\_ebs\_csi\_driver](#module\_aws\_ebs\_csi\_driver) | ./modules/aws-ebs-csi-driver | n/a |
| <a name="module_aws_efs_csi_driver"></a> [aws\_efs\_csi\_driver](#module\_aws\_efs\_csi\_driver) | ./modules/aws-efs-csi-driver | n/a |
| <a name="module_aws_for_fluent_bit"></a> [aws\_for\_fluent\_bit](#module\_aws\_for\_fluent\_bit) | ./modules/aws-for-fluentbit | n/a |
| <a name="module_aws_fsx_csi_driver"></a> [aws\_fsx\_csi\_driver](#module\_aws\_fsx\_csi\_driver) | ./modules/aws-fsx-csi-driver | n/a |
| <a name="module_aws_kube_proxy"></a> [aws\_kube\_proxy](#module\_aws\_kube\_proxy) | ./modules/aws-kube-proxy | n/a |
| <a name="module_aws_load_balancer_controller"></a> [aws\_load\_balancer\_controller](#module\_aws\_load\_balancer\_controller) | ./modules/aws-load-balancer-controller | n/a |
| <a name="module_aws_node_termination_handler"></a> [aws\_node\_termination\_handler](#module\_aws\_node\_termination\_handler) | ./modules/aws-node-termination-handler | n/a |
| <a name="module_aws_privateca_issuer"></a> [aws\_privateca\_issuer](#module\_aws\_privateca\_issuer) | ./modules/aws-privateca-issuer | n/a |
| <a name="module_aws_vpc_cni"></a> [aws\_vpc\_cni](#module\_aws\_vpc\_cni) | ./modules/aws-vpc-cni | n/a |
| <a name="module_cert_manager"></a> [cert\_manager](#module\_cert\_manager) | ./modules/cert-manager | n/a |
| <a name="module_cluster_autoscaler"></a> [cluster\_autoscaler](#module\_cluster\_autoscaler) | ./modules/cluster-autoscaler | n/a |
| <a name="module_csi_secrets_store_provider_aws"></a> [csi\_secrets\_store\_provider\_aws](#module\_csi\_secrets\_store\_provider\_aws) | ./modules/csi-secrets-store-provider-aws | n/a |
| <a name="module_external_dns"></a> [external\_dns](#module\_external\_dns) | ./modules/external-dns | n/a |
| <a name="module_external_secrets"></a> [external\_secrets](#module\_external\_secrets) | ./modules/external-secrets | n/a |
| <a name="module_fargate_fluentbit"></a> [fargate\_fluentbit](#module\_fargate\_fluentbit) | ./modules/fargate-fluentbit | n/a |
| <a name="module_gatekeeper"></a> [gatekeeper](#module\_gatekeeper) | ./modules/gatekeeper | n/a |
| <a name="module_grafana"></a> [grafana](#module\_grafana) | ./modules/grafana | n/a |
| <a name="module_ingress_nginx"></a> [ingress\_nginx](#module\_ingress\_nginx) | ./modules/ingress-nginx | n/a |
| <a name="module_karpenter"></a> [karpenter](#module\_karpenter) | ./modules/karpenter | n/a |
| <a name="module_kube_prometheus_stack"></a> [kube\_prometheus\_stack](#module\_kube\_prometheus\_stack) | ./modules/kube-prometheus-stack | n/a |
| <a name="module_metrics_server"></a> [metrics\_server](#module\_metrics\_server) | ./modules/metrics-server | n/a |
| <a name="module_opentelemetry_operator"></a> [opentelemetry\_operator](#module\_opentelemetry\_operator) | ./modules/opentelemetry-operator | n/a |
| <a name="module_prometheus"></a> [prometheus](#module\_prometheus) | ./modules/prometheus | n/a |
| <a name="module_promtail"></a> [promtail](#module\_promtail) | ./modules/promtail | n/a |
| <a name="module_secrets_store_csi_driver"></a> [secrets\_store\_csi\_driver](#module\_secrets\_store\_csi\_driver) | ./modules/secrets-store-csi-driver | n/a |
| <a name="module_velero"></a> [velero](#module\_velero) | ./modules/velero | n/a |
| <a name="module_vpa"></a> [vpa](#module\_vpa) | ./modules/vpa | n/a |

## Resources

| Name | Type |
|------|------|
| [time_sleep.dataplane](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amazon_eks_adot_config"></a> [amazon\_eks\_adot\_config](#input\_amazon\_eks\_adot\_config) | Configuration for Amazon EKS ADOT add-on | `any` | `{}` | no |
| <a name="input_amazon_eks_aws_ebs_csi_driver_config"></a> [amazon\_eks\_aws\_ebs\_csi\_driver\_config](#input\_amazon\_eks\_aws\_ebs\_csi\_driver\_config) | configMap for AWS EBS CSI Driver add-on | `any` | `{}` | no |
| <a name="input_amazon_eks_coredns_config"></a> [amazon\_eks\_coredns\_config](#input\_amazon\_eks\_coredns\_config) | Configuration for Amazon CoreDNS EKS add-on | `any` | `{}` | no |
| <a name="input_amazon_eks_kube_proxy_config"></a> [amazon\_eks\_kube\_proxy\_config](#input\_amazon\_eks\_kube\_proxy\_config) | ConfigMap for Amazon EKS Kube-Proxy add-on | `any` | `{}` | no |
| <a name="input_amazon_eks_vpc_cni_config"></a> [amazon\_eks\_vpc\_cni\_config](#input\_amazon\_eks\_vpc\_cni\_config) | ConfigMap of Amazon EKS VPC CNI add-on | `any` | `{}` | no |
| <a name="input_amazon_prometheus_workspace_endpoint"></a> [amazon\_prometheus\_workspace\_endpoint](#input\_amazon\_prometheus\_workspace\_endpoint) | AWS Managed Prometheus WorkSpace Endpoint | `string` | `null` | no |
| <a name="input_argo_rollouts"></a> [argo\_rollouts](#input\_argo\_rollouts) | Argo Rollouts addon configuration values | `any` | `{}` | no |
| <a name="input_argo_workflows"></a> [argo\_workflows](#input\_argo\_workflows) | Argo Workflows addon configuration values | `any` | `{}` | no |
| <a name="input_argocd_applications"></a> [argocd\_applications](#input\_argocd\_applications) | Argo CD Applications config to bootstrap the cluster | `any` | `{}` | no |
| <a name="input_argocd_helm_config"></a> [argocd\_helm\_config](#input\_argocd\_helm\_config) | Argo CD Kubernetes add-on config | `any` | `{}` | no |
| <a name="input_argocd_manage_add_ons"></a> [argocd\_manage\_add\_ons](#input\_argocd\_manage\_add\_ons) | Enable managing add-on configuration via ArgoCD App of Apps | `bool` | `false` | no |
| <a name="input_auto_scaling_group_names"></a> [auto\_scaling\_group\_names](#input\_auto\_scaling\_group\_names) | List of self-managed node groups autoscaling group names | `list(string)` | `[]` | no |
| <a name="input_aws_cloudwatch_metrics_helm_config"></a> [aws\_cloudwatch\_metrics\_helm\_config](#input\_aws\_cloudwatch\_metrics\_helm\_config) | AWS CloudWatch Metrics Helm Chart config | `any` | `{}` | no |
| <a name="input_aws_cloudwatch_metrics_irsa_policies"></a> [aws\_cloudwatch\_metrics\_irsa\_policies](#input\_aws\_cloudwatch\_metrics\_irsa\_policies) | Additional IAM policies for a IAM role for service accounts | `list(string)` | `[]` | no |
| <a name="input_aws_efs_csi_driver_helm_config"></a> [aws\_efs\_csi\_driver\_helm\_config](#input\_aws\_efs\_csi\_driver\_helm\_config) | AWS EFS CSI driver Helm Chart config | `any` | `{}` | no |
| <a name="input_aws_efs_csi_driver_irsa_policies"></a> [aws\_efs\_csi\_driver\_irsa\_policies](#input\_aws\_efs\_csi\_driver\_irsa\_policies) | Additional IAM policies for a IAM role for service accounts | `list(string)` | `[]` | no |
| <a name="input_aws_for_fluentbit_create_cw_log_group"></a> [aws\_for\_fluentbit\_create\_cw\_log\_group](#input\_aws\_for\_fluentbit\_create\_cw\_log\_group) | Set to false to use existing CloudWatch log group supplied via the cw\_log\_group\_name variable. | `bool` | `true` | no |
| <a name="input_aws_for_fluentbit_cw_log_group_kms_key_arn"></a> [aws\_for\_fluentbit\_cw\_log\_group\_kms\_key\_arn](#input\_aws\_for\_fluentbit\_cw\_log\_group\_kms\_key\_arn) | FluentBit CloudWatch Log group KMS Key | `string` | `null` | no |
| <a name="input_aws_for_fluentbit_cw_log_group_name"></a> [aws\_for\_fluentbit\_cw\_log\_group\_name](#input\_aws\_for\_fluentbit\_cw\_log\_group\_name) | FluentBit CloudWatch Log group name | `string` | `null` | no |
| <a name="input_aws_for_fluentbit_cw_log_group_retention"></a> [aws\_for\_fluentbit\_cw\_log\_group\_retention](#input\_aws\_for\_fluentbit\_cw\_log\_group\_retention) | FluentBit CloudWatch Log group retention period | `number` | `90` | no |
| <a name="input_aws_for_fluentbit_cw_log_group_skip_destroy"></a> [aws\_for\_fluentbit\_cw\_log\_group\_skip\_destroy](#input\_aws\_for\_fluentbit\_cw\_log\_group\_skip\_destroy) | Set to true if you do not wish the log group (and any logs it may contain) to be deleted at destroy time | `bool` | `true` | no |
| <a name="input_aws_for_fluentbit_helm_config"></a> [aws\_for\_fluentbit\_helm\_config](#input\_aws\_for\_fluentbit\_helm\_config) | AWS for FluentBit Helm Chart config | `any` | `{}` | no |
| <a name="input_aws_for_fluentbit_irsa_policies"></a> [aws\_for\_fluentbit\_irsa\_policies](#input\_aws\_for\_fluentbit\_irsa\_policies) | Additional IAM policies for a IAM role for service accounts | `list(string)` | `[]` | no |
| <a name="input_aws_fsx_csi_driver_helm_config"></a> [aws\_fsx\_csi\_driver\_helm\_config](#input\_aws\_fsx\_csi\_driver\_helm\_config) | AWS FSx CSI driver Helm Chart config | `any` | `{}` | no |
| <a name="input_aws_fsx_csi_driver_irsa_policies"></a> [aws\_fsx\_csi\_driver\_irsa\_policies](#input\_aws\_fsx\_csi\_driver\_irsa\_policies) | Additional IAM policies for a IAM role for service accounts | `list(string)` | `[]` | no |
| <a name="input_aws_load_balancer_controller_helm_config"></a> [aws\_load\_balancer\_controller\_helm\_config](#input\_aws\_load\_balancer\_controller\_helm\_config) | AWS Load Balancer Controller Helm Chart config | `any` | `{}` | no |
| <a name="input_aws_node_termination_handler_helm_config"></a> [aws\_node\_termination\_handler\_helm\_config](#input\_aws\_node\_termination\_handler\_helm\_config) | AWS Node Termination Handler Helm Chart config | `any` | `{}` | no |
| <a name="input_aws_node_termination_handler_irsa_policies"></a> [aws\_node\_termination\_handler\_irsa\_policies](#input\_aws\_node\_termination\_handler\_irsa\_policies) | Additional IAM policies for a IAM role for service accounts | `list(string)` | `[]` | no |
| <a name="input_aws_privateca_acmca_arn"></a> [aws\_privateca\_acmca\_arn](#input\_aws\_privateca\_acmca\_arn) | ARN of AWS ACM PCA | `string` | `""` | no |
| <a name="input_aws_privateca_issuer_helm_config"></a> [aws\_privateca\_issuer\_helm\_config](#input\_aws\_privateca\_issuer\_helm\_config) | PCA Issuer Helm Chart config | `any` | `{}` | no |
| <a name="input_aws_privateca_issuer_irsa_policies"></a> [aws\_privateca\_issuer\_irsa\_policies](#input\_aws\_privateca\_issuer\_irsa\_policies) | IAM policy ARNs for AWS ACM PCA IRSA | `list(string)` | `[]` | no |
| <a name="input_cert_manager_domain_names"></a> [cert\_manager\_domain\_names](#input\_cert\_manager\_domain\_names) | Domain names of the Route53 hosted zone to use with cert-manager | `list(string)` | `[]` | no |
| <a name="input_cert_manager_helm_config"></a> [cert\_manager\_helm\_config](#input\_cert\_manager\_helm\_config) | Cert Manager Helm Chart config | `any` | `{}` | no |
| <a name="input_cert_manager_install_letsencrypt_issuers"></a> [cert\_manager\_install\_letsencrypt\_issuers](#input\_cert\_manager\_install\_letsencrypt\_issuers) | Install Let's Encrypt Cluster Issuers | `bool` | `true` | no |
| <a name="input_cert_manager_irsa_policies"></a> [cert\_manager\_irsa\_policies](#input\_cert\_manager\_irsa\_policies) | Additional IAM policies for a IAM role for service accounts | `list(string)` | `[]` | no |
| <a name="input_cert_manager_kubernetes_svc_image_pull_secrets"></a> [cert\_manager\_kubernetes\_svc\_image\_pull\_secrets](#input\_cert\_manager\_kubernetes\_svc\_image\_pull\_secrets) | list(string) of kubernetes imagePullSecrets | `list(string)` | `[]` | no |
| <a name="input_cert_manager_letsencrypt_email"></a> [cert\_manager\_letsencrypt\_email](#input\_cert\_manager\_letsencrypt\_email) | Email address for expiration emails from Let's Encrypt | `string` | `""` | no |
| <a name="input_cluster_autoscaler_helm_config"></a> [cluster\_autoscaler\_helm\_config](#input\_cluster\_autoscaler\_helm\_config) | Cluster Autoscaler Helm Chart config | `any` | `{}` | no |
| <a name="input_coredns_cluster_proportional_autoscaler_helm_config"></a> [coredns\_cluster\_proportional\_autoscaler\_helm\_config](#input\_coredns\_cluster\_proportional\_autoscaler\_helm\_config) | Helm provider config for the CoreDNS cluster-proportional-autoscaler | `any` | `{}` | no |
| <a name="input_csi_secrets_store_provider_aws_helm_config"></a> [csi\_secrets\_store\_provider\_aws\_helm\_config](#input\_csi\_secrets\_store\_provider\_aws\_helm\_config) | CSI Secrets Store Provider AWS Helm Configurations | `any` | `null` | no |
| <a name="input_custom_image_registry_uri"></a> [custom\_image\_registry\_uri](#input\_custom\_image\_registry\_uri) | Custom image registry URI map of `{region = dkr.endpoint }` | `map(string)` | `{}` | no |
| <a name="input_data_plane_wait_arn"></a> [data\_plane\_wait\_arn](#input\_data\_plane\_wait\_arn) | Addon deployment will not proceed until this value is known. Set to node group/Fargate profile ARN to wait for data plane to be ready before provisioning addons | `string` | `""` | no |
| <a name="input_eks_cluster_domain"></a> [eks\_cluster\_domain](#input\_eks\_cluster\_domain) | The domain for the EKS cluster | `string` | `""` | no |
| <a name="input_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#input\_eks\_cluster\_endpoint) | Endpoint for your Kubernetes API server | `string` | `null` | no |
| <a name="input_eks_cluster_id"></a> [eks\_cluster\_id](#input\_eks\_cluster\_id) | EKS Cluster Id | `string` | n/a | yes |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | The Kubernetes version for the cluster | `string` | `null` | no |
| <a name="input_eks_oidc_provider"></a> [eks\_oidc\_provider](#input\_eks\_oidc\_provider) | The OpenID Connect identity provider (issuer URL without leading `https://`) | `string` | `null` | no |
| <a name="input_enable_amazon_eks_adot"></a> [enable\_amazon\_eks\_adot](#input\_enable\_amazon\_eks\_adot) | Enable Amazon EKS ADOT addon | `bool` | `false` | no |
| <a name="input_enable_amazon_eks_aws_ebs_csi_driver"></a> [enable\_amazon\_eks\_aws\_ebs\_csi\_driver](#input\_enable\_amazon\_eks\_aws\_ebs\_csi\_driver) | Enable EKS Managed AWS EBS CSI Driver add-on; enable\_amazon\_eks\_aws\_ebs\_csi\_driver and enable\_self\_managed\_aws\_ebs\_csi\_driver are mutually exclusive | `bool` | `false` | no |
| <a name="input_enable_amazon_eks_coredns"></a> [enable\_amazon\_eks\_coredns](#input\_enable\_amazon\_eks\_coredns) | Enable Amazon EKS CoreDNS add-on | `bool` | `false` | no |
| <a name="input_enable_amazon_eks_kube_proxy"></a> [enable\_amazon\_eks\_kube\_proxy](#input\_enable\_amazon\_eks\_kube\_proxy) | Enable Kube Proxy add-on | `bool` | `false` | no |
| <a name="input_enable_amazon_eks_vpc_cni"></a> [enable\_amazon\_eks\_vpc\_cni](#input\_enable\_amazon\_eks\_vpc\_cni) | Enable VPC CNI add-on | `bool` | `false` | no |
| <a name="input_enable_amazon_prometheus"></a> [enable\_amazon\_prometheus](#input\_enable\_amazon\_prometheus) | Enable AWS Managed Prometheus service | `bool` | `false` | no |
| <a name="input_enable_argo_rollouts"></a> [enable\_argo\_rollouts](#input\_enable\_argo\_rollouts) | Enable Argo Rollouts add-on | `bool` | `false` | no |
| <a name="input_enable_argo_rollouts_gitops"></a> [enable\_argo\_rollouts\_gitops](#input\_enable\_argo\_rollouts\_gitops) | Enable Argo Rollouts using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_argo_workflows"></a> [enable\_argo\_workflows](#input\_enable\_argo\_workflows) | Enable Argo workflows add-on | `bool` | `false` | no |
| <a name="input_enable_argo_workflows_gitops"></a> [enable\_argo\_workflows\_gitops](#input\_enable\_argo\_workflows\_gitops) | Enable Argo Workflows using GitOps add-on | `bool` | `false` | no |
| <a name="input_enable_argocd"></a> [enable\_argocd](#input\_enable\_argocd) | Enable Argo CD Kubernetes add-on | `bool` | `false` | no |
| <a name="input_enable_aws_cloudwatch_metrics"></a> [enable\_aws\_cloudwatch\_metrics](#input\_enable\_aws\_cloudwatch\_metrics) | Enable AWS CloudWatch Metrics add-on for Container Insights | `bool` | `false` | no |
| <a name="input_enable_aws_efs_csi_driver"></a> [enable\_aws\_efs\_csi\_driver](#input\_enable\_aws\_efs\_csi\_driver) | Enable AWS EFS CSI driver add-on | `bool` | `false` | no |
| <a name="input_enable_aws_for_fluentbit"></a> [enable\_aws\_for\_fluentbit](#input\_enable\_aws\_for\_fluentbit) | Enable AWS for FluentBit add-on | `bool` | `false` | no |
| <a name="input_enable_aws_fsx_csi_driver"></a> [enable\_aws\_fsx\_csi\_driver](#input\_enable\_aws\_fsx\_csi\_driver) | Enable AWS FSx CSI driver add-on | `bool` | `false` | no |
| <a name="input_enable_aws_load_balancer_controller"></a> [enable\_aws\_load\_balancer\_controller](#input\_enable\_aws\_load\_balancer\_controller) | Enable AWS Load Balancer Controller add-on | `bool` | `false` | no |
| <a name="input_enable_aws_node_termination_handler"></a> [enable\_aws\_node\_termination\_handler](#input\_enable\_aws\_node\_termination\_handler) | Enable AWS Node Termination Handler add-on | `bool` | `false` | no |
| <a name="input_enable_aws_privateca_issuer"></a> [enable\_aws\_privateca\_issuer](#input\_enable\_aws\_privateca\_issuer) | Enable PCA Issuer | `bool` | `false` | no |
| <a name="input_enable_cert_manager"></a> [enable\_cert\_manager](#input\_enable\_cert\_manager) | Enable Cert Manager add-on | `bool` | `false` | no |
| <a name="input_enable_cluster_autoscaler"></a> [enable\_cluster\_autoscaler](#input\_enable\_cluster\_autoscaler) | Enable Cluster autoscaler add-on | `bool` | `false` | no |
| <a name="input_enable_coredns_cluster_proportional_autoscaler"></a> [enable\_coredns\_cluster\_proportional\_autoscaler](#input\_enable\_coredns\_cluster\_proportional\_autoscaler) | Enable cluster-proportional-autoscaler for CoreDNS | `bool` | `true` | no |
| <a name="input_enable_external_dns"></a> [enable\_external\_dns](#input\_enable\_external\_dns) | External DNS add-on | `bool` | `false` | no |
| <a name="input_enable_external_secrets"></a> [enable\_external\_secrets](#input\_enable\_external\_secrets) | Enable External Secrets operator add-on | `bool` | `false` | no |
| <a name="input_enable_fargate_fluentbit"></a> [enable\_fargate\_fluentbit](#input\_enable\_fargate\_fluentbit) | Enable Fargate FluentBit add-on | `bool` | `false` | no |
| <a name="input_enable_gatekeeper"></a> [enable\_gatekeeper](#input\_enable\_gatekeeper) | Enable Gatekeeper add-on | `bool` | `false` | no |
| <a name="input_enable_grafana"></a> [enable\_grafana](#input\_enable\_grafana) | Enable Grafana add-on | `bool` | `false` | no |
| <a name="input_enable_ingress_nginx"></a> [enable\_ingress\_nginx](#input\_enable\_ingress\_nginx) | Enable Ingress Nginx add-on | `bool` | `false` | no |
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Enable Ipv6 network. Attaches new VPC CNI policy to the IRSA role | `bool` | `false` | no |
| <a name="input_enable_karpenter"></a> [enable\_karpenter](#input\_enable\_karpenter) | Enable Karpenter autoscaler add-on | `bool` | `false` | no |
| <a name="input_enable_kube_prometheus_stack"></a> [enable\_kube\_prometheus\_stack](#input\_enable\_kube\_prometheus\_stack) | Enable Community kube-prometheus-stack add-on | `bool` | `false` | no |
| <a name="input_enable_metrics_server"></a> [enable\_metrics\_server](#input\_enable\_metrics\_server) | Enable metrics server add-on | `bool` | `false` | no |
| <a name="input_enable_opentelemetry_operator"></a> [enable\_opentelemetry\_operator](#input\_enable\_opentelemetry\_operator) | Enable opentelemetry operator add-on | `bool` | `false` | no |
| <a name="input_enable_prometheus"></a> [enable\_prometheus](#input\_enable\_prometheus) | Enable Community Prometheus add-on | `bool` | `false` | no |
| <a name="input_enable_promtail"></a> [enable\_promtail](#input\_enable\_promtail) | Enable Promtail add-on | `bool` | `false` | no |
| <a name="input_enable_secrets_store_csi_driver"></a> [enable\_secrets\_store\_csi\_driver](#input\_enable\_secrets\_store\_csi\_driver) | Enable CSI Secrets Store Provider | `bool` | `false` | no |
| <a name="input_enable_secrets_store_csi_driver_provider_aws"></a> [enable\_secrets\_store\_csi\_driver\_provider\_aws](#input\_enable\_secrets\_store\_csi\_driver\_provider\_aws) | Enable AWS CSI Secrets Store Provider | `bool` | `false` | no |
| <a name="input_enable_self_managed_aws_ebs_csi_driver"></a> [enable\_self\_managed\_aws\_ebs\_csi\_driver](#input\_enable\_self\_managed\_aws\_ebs\_csi\_driver) | Enable self-managed aws-ebs-csi-driver add-on; enable\_self\_managed\_aws\_ebs\_csi\_driver and enable\_amazon\_eks\_aws\_ebs\_csi\_driver are mutually exclusive | `bool` | `false` | no |
| <a name="input_enable_self_managed_coredns"></a> [enable\_self\_managed\_coredns](#input\_enable\_self\_managed\_coredns) | Enable self-managed CoreDNS add-on | `bool` | `false` | no |
| <a name="input_enable_velero"></a> [enable\_velero](#input\_enable\_velero) | Enable Kubernetes Dashboard add-on | `bool` | `false` | no |
| <a name="input_enable_vpa"></a> [enable\_vpa](#input\_enable\_vpa) | Enable Vertical Pod Autoscaler add-on | `bool` | `false` | no |
| <a name="input_external_dns_helm_config"></a> [external\_dns\_helm\_config](#input\_external\_dns\_helm\_config) | External DNS Helm Chart config | `any` | `{}` | no |
| <a name="input_external_dns_irsa_policies"></a> [external\_dns\_irsa\_policies](#input\_external\_dns\_irsa\_policies) | Additional IAM policies for a IAM role for service accounts | `list(string)` | `[]` | no |
| <a name="input_external_dns_private_zone"></a> [external\_dns\_private\_zone](#input\_external\_dns\_private\_zone) | Determines if referenced Route53 zone is private. | `bool` | `false` | no |
| <a name="input_external_dns_route53_zone_arns"></a> [external\_dns\_route53\_zone\_arns](#input\_external\_dns\_route53\_zone\_arns) | List of Route53 zones ARNs which external-dns will have access to create/manage records | `list(string)` | `[]` | no |
| <a name="input_external_secrets_helm_config"></a> [external\_secrets\_helm\_config](#input\_external\_secrets\_helm\_config) | External Secrets operator Helm Chart config | `any` | `{}` | no |
| <a name="input_external_secrets_irsa_policies"></a> [external\_secrets\_irsa\_policies](#input\_external\_secrets\_irsa\_policies) | Additional IAM policies for a IAM role for service accounts | `list(string)` | `[]` | no |
| <a name="input_external_secrets_secrets_manager_arns"></a> [external\_secrets\_secrets\_manager\_arns](#input\_external\_secrets\_secrets\_manager\_arns) | List of Secrets Manager ARNs that contain secrets to mount using External Secrets | `list(string)` | <pre>[<br>  "arn:aws:secretsmanager:*:*:secret:*"<br>]</pre> | no |
| <a name="input_external_secrets_ssm_parameter_arns"></a> [external\_secrets\_ssm\_parameter\_arns](#input\_external\_secrets\_ssm\_parameter\_arns) | List of Systems Manager Parameter ARNs that contain secrets to mount using External Secrets | `list(string)` | <pre>[<br>  "arn:aws:ssm:*:*:parameter/*"<br>]</pre> | no |
| <a name="input_fargate_fluentbit_addon_config"></a> [fargate\_fluentbit\_addon\_config](#input\_fargate\_fluentbit\_addon\_config) | Fargate fluentbit add-on config | `any` | `{}` | no |
| <a name="input_gatekeeper_helm_config"></a> [gatekeeper\_helm\_config](#input\_gatekeeper\_helm\_config) | Gatekeeper Helm Chart config | `any` | `{}` | no |
| <a name="input_grafana_helm_config"></a> [grafana\_helm\_config](#input\_grafana\_helm\_config) | Kubernetes Grafana Helm Chart config | `any` | `null` | no |
| <a name="input_grafana_irsa_policies"></a> [grafana\_irsa\_policies](#input\_grafana\_irsa\_policies) | IAM policy ARNs for grafana IRSA | `list(string)` | `[]` | no |
| <a name="input_ingress_nginx_helm_config"></a> [ingress\_nginx\_helm\_config](#input\_ingress\_nginx\_helm\_config) | Ingress Nginx Helm Chart config | `any` | `{}` | no |
| <a name="input_irsa_iam_permissions_boundary"></a> [irsa\_iam\_permissions\_boundary](#input\_irsa\_iam\_permissions\_boundary) | IAM permissions boundary for IRSA roles | `string` | `""` | no |
| <a name="input_irsa_iam_role_path"></a> [irsa\_iam\_role\_path](#input\_irsa\_iam\_role\_path) | IAM role path for IRSA roles | `string` | `"/"` | no |
| <a name="input_karpenter_enable_spot_termination_handling"></a> [karpenter\_enable\_spot\_termination\_handling](#input\_karpenter\_enable\_spot\_termination\_handling) | Determines whether to enable native spot termination handling | `bool` | `false` | no |
| <a name="input_karpenter_event_rule_name_prefix"></a> [karpenter\_event\_rule\_name\_prefix](#input\_karpenter\_event\_rule\_name\_prefix) | Prefix used for karpenter event bridge rules | `string` | `""` | no |
| <a name="input_karpenter_helm_config"></a> [karpenter\_helm\_config](#input\_karpenter\_helm\_config) | Karpenter autoscaler add-on config | `any` | `{}` | no |
| <a name="input_karpenter_irsa_policies"></a> [karpenter\_irsa\_policies](#input\_karpenter\_irsa\_policies) | Additional IAM policies for a IAM role for service accounts | `list(string)` | `[]` | no |
| <a name="input_karpenter_node_iam_instance_profile"></a> [karpenter\_node\_iam\_instance\_profile](#input\_karpenter\_node\_iam\_instance\_profile) | Karpenter Node IAM Instance profile id | `string` | `""` | no |
| <a name="input_kube_prometheus_stack_helm_config"></a> [kube\_prometheus\_stack\_helm\_config](#input\_kube\_prometheus\_stack\_helm\_config) | Community kube-prometheus-stack Helm Chart config | `any` | `{}` | no |
| <a name="input_metrics_server_helm_config"></a> [metrics\_server\_helm\_config](#input\_metrics\_server\_helm\_config) | Metrics Server Helm Chart config | `any` | `{}` | no |
| <a name="input_opentelemetry_operator_helm_config"></a> [opentelemetry\_operator\_helm\_config](#input\_opentelemetry\_operator\_helm\_config) | Opentelemetry Operator Helm Chart config | `any` | `{}` | no |
| <a name="input_prometheus_helm_config"></a> [prometheus\_helm\_config](#input\_prometheus\_helm\_config) | Community Prometheus Helm Chart config | `any` | `{}` | no |
| <a name="input_promtail_helm_config"></a> [promtail\_helm\_config](#input\_promtail\_helm\_config) | Promtail Helm Chart config | `any` | `{}` | no |
| <a name="input_remove_default_coredns_deployment"></a> [remove\_default\_coredns\_deployment](#input\_remove\_default\_coredns\_deployment) | Determines whether the default deployment of CoreDNS is removed and ownership of kube-dns passed to Helm | `bool` | `false` | no |
| <a name="input_secrets_store_csi_driver_helm_config"></a> [secrets\_store\_csi\_driver\_helm\_config](#input\_secrets\_store\_csi\_driver\_helm\_config) | CSI Secrets Store Provider Helm Configurations | `any` | `null` | no |
| <a name="input_self_managed_aws_ebs_csi_driver_helm_config"></a> [self\_managed\_aws\_ebs\_csi\_driver\_helm\_config](#input\_self\_managed\_aws\_ebs\_csi\_driver\_helm\_config) | Self-managed aws-ebs-csi-driver Helm chart config | `any` | `{}` | no |
| <a name="input_self_managed_coredns_helm_config"></a> [self\_managed\_coredns\_helm\_config](#input\_self\_managed\_coredns\_helm\_config) | Self-managed CoreDNS Helm chart config | `any` | `{}` | no |
| <a name="input_sqs_queue_kms_data_key_reuse_period_seconds"></a> [sqs\_queue\_kms\_data\_key\_reuse\_period\_seconds](#input\_sqs\_queue\_kms\_data\_key\_reuse\_period\_seconds) | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again | `number` | `null` | no |
| <a name="input_sqs_queue_kms_master_key_id"></a> [sqs\_queue\_kms\_master\_key\_id](#input\_sqs\_queue\_kms\_master\_key\_id) | The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK | `string` | `null` | no |
| <a name="input_sqs_queue_managed_sse_enabled"></a> [sqs\_queue\_managed\_sse\_enabled](#input\_sqs\_queue\_managed\_sse\_enabled) | Enable server-side encryption (SSE) for a SQS queue | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map(string)` | `{}` | no |
| <a name="input_velero_backup_s3_bucket"></a> [velero\_backup\_s3\_bucket](#input\_velero\_backup\_s3\_bucket) | Bucket name for velero bucket | `string` | `""` | no |
| <a name="input_velero_helm_config"></a> [velero\_helm\_config](#input\_velero\_helm\_config) | Kubernetes Velero Helm Chart config | `any` | `null` | no |
| <a name="input_velero_irsa_policies"></a> [velero\_irsa\_policies](#input\_velero\_irsa\_policies) | IAM policy ARNs for velero IRSA | `list(string)` | `[]` | no |
| <a name="input_vpa_helm_config"></a> [vpa\_helm\_config](#input\_vpa\_helm\_config) | VPA Helm Chart config | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_argo_rollouts"></a> [argo\_rollouts](#output\_argo\_rollouts) | Map of attributes of the Helm release created |
| <a name="output_argo_workflows"></a> [argo\_workflows](#output\_argo\_workflows) | Map of attributes of the Helm release and IRSA created |
| <a name="output_argocd"></a> [argocd](#output\_argocd) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_cloudwatch_metrics"></a> [aws\_cloudwatch\_metrics](#output\_aws\_cloudwatch\_metrics) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_coredns"></a> [aws\_coredns](#output\_aws\_coredns) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_ebs_csi_driver"></a> [aws\_ebs\_csi\_driver](#output\_aws\_ebs\_csi\_driver) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_efs_csi_driver"></a> [aws\_efs\_csi\_driver](#output\_aws\_efs\_csi\_driver) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_for_fluent_bit"></a> [aws\_for\_fluent\_bit](#output\_aws\_for\_fluent\_bit) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_fsx_csi_driver"></a> [aws\_fsx\_csi\_driver](#output\_aws\_fsx\_csi\_driver) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_kube_proxy"></a> [aws\_kube\_proxy](#output\_aws\_kube\_proxy) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_load_balancer_controller"></a> [aws\_load\_balancer\_controller](#output\_aws\_load\_balancer\_controller) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_node_termination_handler"></a> [aws\_node\_termination\_handler](#output\_aws\_node\_termination\_handler) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_privateca_issuer"></a> [aws\_privateca\_issuer](#output\_aws\_privateca\_issuer) | Map of attributes of the Helm release and IRSA created |
| <a name="output_aws_vpc_cni"></a> [aws\_vpc\_cni](#output\_aws\_vpc\_cni) | Map of attributes of the Helm release and IRSA created |
| <a name="output_cert_manager"></a> [cert\_manager](#output\_cert\_manager) | Map of attributes of the Helm release and IRSA created |
| <a name="output_cluster_autoscaler"></a> [cluster\_autoscaler](#output\_cluster\_autoscaler) | Map of attributes of the Helm release and IRSA created |
| <a name="output_csi_secrets_store_provider_aws"></a> [csi\_secrets\_store\_provider\_aws](#output\_csi\_secrets\_store\_provider\_aws) | Map of attributes of the Helm release and IRSA created |
| <a name="output_external_dns"></a> [external\_dns](#output\_external\_dns) | Map of attributes of the Helm release and IRSA created |
| <a name="output_external_secrets"></a> [external\_secrets](#output\_external\_secrets) | Map of attributes of the Helm release and IRSA created |
| <a name="output_fargate_fluentbit"></a> [fargate\_fluentbit](#output\_fargate\_fluentbit) | Map of attributes of the Helm release and IRSA created |
| <a name="output_gatekeeper"></a> [gatekeeper](#output\_gatekeeper) | Map of attributes of the Helm release and IRSA created |
| <a name="output_grafana"></a> [grafana](#output\_grafana) | Map of attributes of the Helm release and IRSA created |
| <a name="output_ingress_nginx"></a> [ingress\_nginx](#output\_ingress\_nginx) | Map of attributes of the Helm release and IRSA created |
| <a name="output_karpenter"></a> [karpenter](#output\_karpenter) | Map of attributes of the Helm release and IRSA created |
| <a name="output_kube_prometheus_stack"></a> [kube\_prometheus\_stack](#output\_kube\_prometheus\_stack) | Map of attributes of the Helm release and IRSA created |
| <a name="output_metrics_server"></a> [metrics\_server](#output\_metrics\_server) | Map of attributes of the Helm release and IRSA created |
| <a name="output_opentelemetry_operator"></a> [opentelemetry\_operator](#output\_opentelemetry\_operator) | Map of attributes of the Helm release and IRSA created |
| <a name="output_prometheus"></a> [prometheus](#output\_prometheus) | Map of attributes of the Helm release and IRSA created |
| <a name="output_promtail"></a> [promtail](#output\_promtail) | Map of attributes of the Helm release and IRSA created |
| <a name="output_secrets_store_csi_driver"></a> [secrets\_store\_csi\_driver](#output\_secrets\_store\_csi\_driver) | Map of attributes of the Helm release and IRSA created |
| <a name="output_velero"></a> [velero](#output\_velero) | Map of attributes of the Helm release and IRSA created |
| <a name="output_vpa"></a> [vpa](#output\_vpa) | Map of attributes of the Helm release and IRSA created |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
