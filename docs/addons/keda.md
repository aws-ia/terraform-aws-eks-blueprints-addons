# KEDA

[KEDA](https://github.com/kedacore/charts/tree/main/keda) allows for fine grained autoscaling (including to/from zero) for event driven Kubernetes workloads. Serves as a Kubernetes Metrics Server and allows users to define autoscaling rules using a dedicated Kubernetes custom resource definition.


## Usage

KEDA can be deployed by enabling the add-on via the following.

```hcl
enable_keda = true
```

You can optionally customize the Helm chart that deploys KEDA via the following configuration.

```hcl
  enable_keda = true

  keda = {
    name          = "keda"
    chart_version = "2.14.2"
    repository    = "https://kedacore.github.io/charts"
    namespace     = "keda"
    values        = [templatefile("${path.module}/values.yaml", {})]
  }
```

Verify keda pods are running.

```sh
$ kubectl get pods -n keda
NAME                                               READY   STATUS    RESTARTS        AGE
keda-admission-webhooks-68b4cfbb48-7z7w8           1/1     Running   0               2m22s
keda-operator-647b44c8bb-wjb6g                     1/1     Running   0   
2m22s
keda-operator-metrics-apiserver-5f945dc9f8-f7529   1/1     Running   0  
2m22s
