# Observe kustomize manifests

This repository contains kustomized Kubernetes manifests supported by Observe.
These are intended as a way of quickly ingesting Kubernetes data into your
Observe instance.

# Quick setup

You can install our kustomize stack directly using `kubectl`:

```
kubectl apply -k github.com/observeinc/manifests//stack
```

This will create an `observe` namespace for you and start collecting Kubernetes state, logs and metrics.
After you have applied the stack, you must create a secret containing your Observe credentials:

```
kubectl -n observe create secret generic credentials \
        --from-literal=OBSERVE_CUSTOMER=${OBSERVE_CUSTOMER?} \
        --from-literal=OBSERVE_TOKEN=${OBSERVE_TOKEN?}
```

The URL format used by kustomize is a `git clone` URL. Attempting to open it
directly in a browser will result in a "page not found" error. If you would
like to inspect the contents of our installation, you can either view the
source on [github](https://github.com/observeinc/manifests/tree/main/stack), or
generate the manifest locally:

```
kubectl kustomize github.com/observeinc/manifests//stack
```

# Versioning

Observe uses versioned manifests. To install or uninstall a specific version, add the version parameter to the URL, e.g:

$ kubectl apply -k 'https://github.com/observeinc/manifests/stack?ref=v0.15.0'

You can find the list of published versions on the
[releases](https://github.com/observeinc/manifests/releases) page.

Releases are automatically cut on a weekly basis on Tuesdays. Release tags
follow [Semantic versioning](https://semver.org/). Bugfixes increment the patch
version number, whereas new features increment the minor version. In the
absence of bugfixes or features, no release is cut.

# Components

We provide four "base" components:

- `bases/events` - responsible for collecting Kubernetes state using `kube-state-events`
- `bases/logs` - responsible for collecting container logs using `fluent-bit`
- `bases/metrics` - responsible for collecting container logs using `grafana-agent`
- `bases/traces` - responsible for collecting traces using `otel-collector`

We compose these base layers into overlays. Our default `stack` overlay
collects events, logs and metrics.

# Sizing

By default, we attempt to choose defaults which have a wide operating
range. However, some clusters will inevitably fall outside this range. We
provide additional configurations that are more appropriate for these extremes:

- `github.com/observeinc//stack/xs` - intended to run on small clusters such as development environments, where resources are scarce and reliability is less of a concern
- `github.com/observeinc//stack/m` - the default sizing, intended to run on clusters with hundreds of pods. Start here and adjust up or down accordingly.
- `github.com/observeinc//stack/l` - used for similar sized clusters as `m`, but with higher throughput in logs, metrics or events. This may be due to verbose logging, high cardinality metrics or frequent cluster reconfiguration.
- `github.com/observeinc//stack/xl` - intended to run on large clusters with 100+ nodes. Collection is preferentially performed using daemonsets rather than deployments.

Resource limits for each sizing is as follows:

|         |      xs      |       m       |       l       |       xl      |
|--------:|:------------:|:-------------:|:-------------:|:-------------:|
|  events |  20m<br>64Mi |  50m<br>256Mi |   200m<br>1Gi |   400m<br>2Gi |
|   logs* |  10m<br>64Mi | 100m<br>128Mi | 200m<br>192Mi | 500m<br>256Mi |
| metrics | 50m<br>256Mi |   250m<br>2Gi | 500m<br>4Gi   |  200m*<br>1Gi |

\* run as daemonset

# Traces

Support for trace collection is currently experimental. You can install
OpenTelemetry support alongside our typical stack by running:

This is a standard deployment of opentelementry adapted from [OpenTelemetry](https://github.com/open-telemetry/opentelemetry-helm-charts/tree/main/charts/opentelemetry-collector/examples)

This stack also includes the required opentelemetry-collector resources:
  Clusterrolebinding
  ClusterRole
  ConfigMap for config.yaml
  
For general application you can use our Kustomize manifests to use a medium daemonset instance of opentelemetry-collector
```
kubectl apply -k github.com/observeinc/manifests/stack/otel
```

You can also use specific sizings:

- `kubectl apply -k github.com/observeinc/manifests/stack/otel/xs`
- `kubectl apply -k github.com/observeinc/manifests/stack/otel/m`
- `kubectl apply -k github.com/observeinc/manifests/stack/otel/l`
- `kubectl apply -k github.com/observeinc/manifests/stack/otel/xl`

The respective opentelemetry-collector continaer for each size:

|         |             xs              |              m               |                     l                      |      xl       |
|--------:|:---------------------------:|:----------------------------:|:------------------------------------------:|:-------------:|
| traces* | 50m<br>128Mi<br>(Daemonset) | 250m<br>256Mi<br>(Daemonset) | 250m<br>256Mi<br>(deployment replicas: 10) | 250m<br>256Mi | points to l 

Once installed, you can forward traces to the local collector over GRPC on 
`observe-traces.observe.svc.cluster.local:4317`.

**NOTE** When migrating from _s_ or _m_ to _l_, ensure that you remove the previous opentelemetry-collector daesmonset
```
$ kubectl -n observe delete daemonset.apps traces
```

# Configuration

## Using kustomize

You can override any individual configuration element by creating a new
kustomized manifest with our kustomized directory as a base.

The following example creates a new directory with `kustomization.yaml` set to
override the `FB_DEBUG` variable in the fluent-bit environment variable
configmap:

```
EXAMPLE_DIR=$(mktemp -d)

cat <<EOF >$EXAMPLE_DIR/kustomization.yaml
bases:
  - github.com/observeinc/manifests//stack?ref=main

configMapGenerator:
  - name: fluent-bit-env
    behavior: merge
    literals:
      - FB_DEBUG=true
EOF
```

You can then apply this configuration directly from kubectl:

```
kubectl apply -k $EXAMPLE_DIR
```

or, alternatively, you can build using your specific `kustomize` version and apply:

```
kustomize build $EXAMPLE_DIR | kubectl apply -f -
```

You can version control your kustomized directory while tracking upstream changes through the use of branch tags.

## Using an override configMap

Alternatively, you can create a configmap in the `observe` namespace containing
overrides for each of our pods. Following the previous example:

```
echo "FB_DEBUG=true" >> example.env
kubectl create configmap -n observe env-overrides --from-env-file example.env
```

Unlike the kustomize method, configuration changes are not picked up
automatically. You must restart pods to pick up the new environment variables:

```
kubectl rollout restart -n observe daemonset
kubectl rollout restart -n observe deployment
```

# Pruning and deletion

All Kubernetes resources installed through this repo will have an
`observeinc.com/component` label. You can therefore use this label for pruning an existing install:

```bash
kubectl kustomize github.com/observeinc/manifests//stack | kubectl apply --prune -l observeinc.com/component -f -
```

To delete an existing install, just use `kubectl delete`:

```bash
kubectl kustomize github.com/observeinc/manifests//stack | kubectl delete -f -
```

