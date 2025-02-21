provider "aws" {
  region = local.region
}

# Required for public ECR where Karpenter artifacts are hosted
provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}

data "aws_availability_zones" "available" {
  # Do not include local zones
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_ecrpublic_authorization_token" "token" {
  provider = aws.virginia
}

locals {
  name   = basename(path.cwd)
  region = "us-west-2"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Blueprint  = local.name
    GithubRepo = "github.com/aws-ia/terraform-aws-eks-blueprints-addons"
  }
}

################################################################################
# Blueprints Addons
################################################################################

module "eks_blueprints_addons" {
  source = "../../"

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

  eks_addons = {
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_driver_irsa.iam_role_arn
    }
    coredns = {
      most_recent = true

      timeouts = {
        create = "25m"
        delete = "10m"
      }
    }
    vpc-cni = {
      most_recent = true
    }
    kube-proxy = {}
  }

  enable_aws_efs_csi_driver                    = true
  enable_aws_fsx_csi_driver                    = true
  enable_argocd                                = true
  enable_argo_rollouts                         = true
  enable_argo_workflows                        = true
  enable_aws_cloudwatch_metrics                = true
  enable_aws_privateca_issuer                  = true
  enable_cluster_autoscaler                    = true
  enable_secrets_store_csi_driver              = true
  enable_secrets_store_csi_driver_provider_aws = true
  enable_kube_prometheus_stack                 = true

  enable_external_dns = true
  external_dns_route53_zone_arns = [
    "arn:aws:route53:::hostedzone/*",
  ]

  enable_external_secrets = true
  enable_gatekeeper       = true
  enable_ingress_nginx    = true

  # Wait for all Cert-manager related resources to be ready
  enable_cert_manager = true
  cert_manager = {
    wait = true
  }

  # Turn off mutation webhook for services to avoid ordering issue
  enable_aws_load_balancer_controller = true
  aws_load_balancer_controller = {
    set = [{
      name  = "enableServiceMutatorWebhook"
      value = "false"
    }]
  }

  enable_vpa               = true
  enable_fargate_fluentbit = true
  enable_aws_for_fluentbit = true
  aws_for_fluentbit_cw_log_group = {
    create          = true
    use_name_prefix = true # Set this to true to enable name prefix
    name_prefix     = "eks-cluster-logs-"
    retention       = 7
  }
  aws_for_fluentbit = {
    enable_containerinsights = true
    kubelet_monitoring       = true
    chart_version            = "0.1.28"
    set = [{
      name  = "cloudWatchLogs.autoCreateGroup"
      value = true
      },
      {
        name  = "hostNetwork"
        value = true
      },
      {
        name  = "dnsPolicy"
        value = "ClusterFirstWithHostNet"
      }
    ]
    s3_bucket_arns = [
      module.velero_backup_s3_bucket.s3_bucket_arn,
      "${module.velero_backup_s3_bucket.s3_bucket_arn}/logs/*"
    ]
  }

  enable_aws_node_termination_handler   = true
  aws_node_termination_handler_asg_arns = [for asg in module.eks.self_managed_node_groups : asg.autoscaling_group_arn]

  enable_karpenter                           = true
  karpenter_enable_instance_profile_creation = true
  # ECR login required
  karpenter = {
    repository_username = data.aws_ecrpublic_authorization_token.token.user_name
    repository_password = data.aws_ecrpublic_authorization_token.token.password
  }

  enable_velero = true
  ## An S3 Bucket ARN is required. This can be declared with or without a Prefix.
  velero = {
    s3_backup_location = "${module.velero_backup_s3_bucket.s3_bucket_arn}/backups"
    values = [
      # https://github.com/vmware-tanzu/helm-charts/issues/550#issuecomment-1959933230
      <<-EOT
        kubectl:
          image:
            tag: 1.29.2-debian-11-r5
      EOT
    ]
  }

  enable_aws_gateway_api_controller = true
  # ECR login required
  aws_gateway_api_controller = {
    repository_username = data.aws_ecrpublic_authorization_token.token.user_name
    repository_password = data.aws_ecrpublic_authorization_token.token.password
    set = [{
      name  = "clusterVpcId"
      value = module.vpc.vpc_id
    }]
  }

  enable_bottlerocket_update_operator = true

  # Pass in any number of Helm charts to be created for those that are not natively supported
  helm_releases = {
    prometheus-adapter = {
      description      = "A Helm chart for k8s prometheus adapter"
      namespace        = "prometheus-adapter"
      create_namespace = true
      chart            = "prometheus-adapter"
      chart_version    = "4.2.0"
      repository       = "https://prometheus-community.github.io/helm-charts"
      values = [
        <<-EOT
          replicas: 2
          podDisruptionBudget:
            enabled: true
        EOT
      ]
    }
    gpu-operator = {
      description      = "A Helm chart for NVIDIA GPU operator"
      namespace        = "gpu-operator"
      create_namespace = true
      chart            = "gpu-operator"
      chart_version    = "v23.9.1"
      repository       = "https://nvidia.github.io/gpu-operator"
      values = [
        <<-EOT
          operator:
            defaultRuntime: containerd
        EOT
      ]
    }
  }

  tags = local.tags
}

################################################################################
# Cluster
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.26"

  cluster_name                   = local.name
  cluster_version                = "1.31"
  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Give the Terraform identity admin access to the cluster
  # which will allow resources to be deployed into the cluster
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    initial = {
      instance_types = ["m5.xlarge"]

      min_size     = 2
      max_size     = 10
      desired_size = 5
    }
  }

  # For demonstrating node-termination-handler
  self_managed_node_groups = {
    default = {
      instance_type = "m5.large"

      min_size     = 1
      max_size     = 10
      desired_size = 1
    }
  }

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags
}

module "velero_backup_s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket_prefix = "${local.name}-"

  # Allow deletion of non-empty bucket
  # NOTE: This is enabled for example usage only, you should not enable this for production workloads
  force_destroy = true

  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true

  acl = "private"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  versioning = {
    status     = true
    mfa_delete = false
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = local.tags
}

module "ebs_csi_driver_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.20"

  role_name_prefix = "${local.name}-ebs-csi-driver-"

  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = local.tags
}
