# Bottlerocket and Bottlerocket Update Operator

[Bottlerocket](https://aws.amazon.com/bottlerocket/) is a Linux-based open-source operating system that focuses on security and maintainability, providing a reliable, consistent, and safe platform for container-based workloads.

The [Bottlerocket Update Operator (BRUPOP)](https://github.com/bottlerocket-os/bottlerocket-update-operator/tree/develop) is a Kubernetes operator that coordinates Bottlerocket updates on hosts in a cluster. It relies on a controller deployment on one node to orchestrate updates across the cluster, an agent daemon set on every Bottlerocket node, which is responsible for periodically querying and performing updates rolled out in waves to reduce the impact of issues, and an API Server that performs additional authorization.

[Cert-manager](https://cert-manager.io/) is required for the API server to use a CA certificate when communicating over SSL with the agents.

- [Helm charts](https://github.com/bottlerocket-os/bottlerocket-update-operator/tree/develop/deploy/charts)

## Requirements

BRUPOP perform updates on Nodes running with Bottlerocket OS only. Here are some code snippets of how to setup up Bottlerocket OS Nodes using Managed Node Groups with [Terraform Amazon EKS module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) and [Karpenter Node Classes](https://karpenter.sh/docs/concepts/nodeclasses/).

Notice the label `bottlerocket.aws/updater-interface-version=2.0.0` set in the `[settings.kubernetes.node-labels]` section. This label is required for the BRUPOP Agent to query and perform updates. Nodes not labeled will not be checked by the agent.

### Managed Node Groups

```hcl
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.21"
...
  eks_managed_node_groups = {
    bottlerocket = {
      platform = "bottlerocket"
      ami_type       = "BOTTLEROCKET_x86_64"
      instance_types = ["m5.large", "m5a.large"]

      iam_role_attach_cni_policy = true

      min_size     = 1
      max_size     = 5
      desired_size = 3

      enable_bootstrap_user_data = true
      bootstrap_extra_args = <<-EOT
            [settings.host-containers.admin]
            enabled = false
            [settings.host-containers.control]
            enabled = true
            [settings.kernel]
            lockdown = "integrity"
            [settings.kubernetes.node-labels]
            "bottlerocket.aws/updater-interface-version" = "2.0.0"
            [settings.kubernetes.node-taints]
            "CriticalAddonsOnly" = "true:NoSchedule"
          EOT
    }
  }
}
```

### Karpenter

```yaml
apiVersion: karpenter.k8s.aws/v1beta1
kind: EC2NodeClass
metadata:
  name: bottlerocket-example
spec:
...
  amiFamily: Bottlerocket
  userData:  |
    [settings.kubernetes]
    "kube-api-qps" = 30
    "shutdown-grace-period" = "30s"
    "shutdown-grace-period-for-critical-pods" = "30s"
    [settings.kubernetes.eviction-hard]
    "memory.available" = "20%"  
    [settings.kubernetes.node-labels]
     "bottlerocket.aws/updater-interface-version" = "2.0.0"
```

## Usage

[BRUPOP](https://github.com/aws-ia/terraform-aws-eks-blueprints-addons/) can be deployed with the default configuration by enabling the add-on via the following. Notice the parameter `wait = true` set for Cert-Manager, this is needed since BRUPOP requires that Cert-Manager CRDs are already present in the cluster to be deployed.

```hcl
module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.13"

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

  enable_cert_manager = true
  cert_manager = {
    wait = true
  }
  enable_bottlerocket_update_operator = true
}
```

You can also customize the Helm charts that deploys `bottlerocket_update_operator` and the `bottlerocket_shadow` via the following configuration:

```hcl
enable_bottlerocket_update_operator           = true

bottlerocket_update_operator = {
  name          = "brupop-operator"
  description   = "A Helm chart for BRUPOP"
  chart_version = "1.3.0"
  namespace     = "brupop"
  set           = [{
    name  = "scheduler_cron_expression"
    value = "0 * * * * * *" # Default Unix Cron syntax, set to check every hour. Example "0 0 23 * * Sat *" Perform update checks every Saturday at 23H / 11PM
    }]
}

bottlerocket_shadow = {
  name          = "brupop-crds"
  description   = "A Helm chart for BRUPOP CRDs"
  chart_version = "1.0.0"
}
```

To see a complete working example, see the [`bottlerocket`](https://github.com/aws-ia/terraform-aws-eks-blueprints/tree/main/patterns/bottlerocket) Blueprints Pattern.

## Validate

1. Run `update-kubeconfig` command:

```bash
aws eks --region <REGION> update-kubeconfig --name <CLUSTER_NAME>
```

2. Test by listing velero resources provisioned:

```bash
$ kubectl -n brupop-bottlerocket-aws get all

NAME                                                READY   STATUS    RESTARTS      AGE
pod/brupop-agent-5nv6m                              1/1     Running   1 (33h ago)   33h
pod/brupop-agent-h4vw9                              1/1     Running   1 (33h ago)   33h
pod/brupop-agent-sr9ms                              1/1     Running   2 (33h ago)   33h
pod/brupop-apiserver-6ccb74f599-4c9lv               1/1     Running   0             33h
pod/brupop-apiserver-6ccb74f599-h6hg8               1/1     Running   0             33h
pod/brupop-apiserver-6ccb74f599-svw8n               1/1     Running   0             33h
pod/brupop-controller-deployment-58d46595cc-7vxnt   1/1     Running   0             33h

NAME                               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/brupop-apiserver           ClusterIP   172.20.153.72   <none>        443/TCP   33h
service/brupop-controller-server   ClusterIP   172.20.7.127    <none>        80/TCP    33h

NAME                          DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/brupop-agent   3         3         3       3            3           <none>          33h

NAME                                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/brupop-apiserver               3/3     3            3           33h
deployment.apps/brupop-controller-deployment   1/1     1            1           33h

NAME                                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/brupop-apiserver-6ccb74f599               3         3         3       33h
replicaset.apps/brupop-controller-deployment-58d46595cc   1         1         1       33h

$ kubectl describe apiservices.apiregistration.k8s.io v2.brupop.bottlerocket.aws
Name:         v2.brupop.bottlerocket.aws
Namespace:  
Labels:       kube-aggregator.kubernetes.io/automanaged=true
Annotations:  <none>
API Version:  apiregistration.k8s.io/v1
Kind:         APIService
Metadata:
  Creation Timestamp:  2024-01-30T16:27:15Z
  Resource Version:    8798
  UID:                 034abe22-7e5f-4040-9b64-8ca9d55a4af6
Spec:
  Group:                   brupop.bottlerocket.aws
  Group Priority Minimum:  1000
  Version:                 v2
  Version Priority:        100
Status:
  Conditions:
    Last Transition Time:  2024-01-30T16:27:15Z
    Message:               Local APIServices are always available
    Reason:                Local
    Status:                True
    Type:                  Available
Events:                    <none>
```

1. If not set during the deployment, add the required label `bottlerocket.aws/updater-interface-version=2.0.0` as shown below to all the Nodes that you want to have updates handled by BRUPOP.

```bash
$ kubectl label node ip-10-0-34-87.us-west-2.compute.internal bottlerocket.aws/updater-interface-version=2.0.0
node/ip-10-0-34-87.us-west-2.compute.internal labeled

$ kubectl get nodes -L bottlerocket.aws/updater-interface-version  
NAME                                        STATUS                     ROLES    AGE   VERSION               UPDATER-INTERFACE-VERSION
ip-10-0-34-87.us-west-2.compute.internal    Ready                      <none>   34h   v1.28.1-eks-d91a302   2.0.0
```

4. Because the default cron schedule for BRUPOP is set to check for updates every minute, you'll be able to see in a few minutes that the Node had it's version updated automatically with no downtime.

```bash
kubectl get nodes
NAME                                        STATUS                     ROLES    AGE   VERSION  
ip-10-0-34-87.us-west-2.compute.internal    Ready                      <none>   34h   v1.28.4-eks-d91a302
```
