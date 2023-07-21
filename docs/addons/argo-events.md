# Argo Events

[Argo Events](https://argoproj.github.io/argo-events/) is an open source container-native event-driven workflow automation framework for Kubernetes which helps you trigger K8s objects, Argo Workflows, Serverless workloads, etc. on events from a variety of sources. Argo Events is implemented as a Kubernetes CRD (Custom Resource Definition).

## Usage

Argo Events can be deployed by enabling the add-on via the following.

```hcl
enable_argo_events = true
```

You can optionally customize the Helm chart that deploys Argo Events via the following configuration.

```hcl
  enable_argo_events = true

  argo_events = {
    name          = "argo-events"
    chart_version = "2.4.0"
    repository    = "https://argoproj.github.io/argo-helm"
    namespace     = "argo-events"
    values        = [templatefile("${path.module}/values.yaml", {})]
  }

```

Verify argo-events pods are running.

```sh
$ kubectl get pods -n argo-events
NAME                                                  READY   STATUS    RESTARTS   AGE
argo-events-controller-manager-bfb894cdb-k8hzn        1/1     Running   0          11m
```
