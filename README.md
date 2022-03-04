# Observe kustomize manifests

This repository contains kustomized Kubernetes manifests supported by Observe.
These are intended as a way of quickly ingesting Kubernetes data into your
Observe instance.

> **WARNING**: we are still iterating towards a stable release. Feedback welcome.

# Quick setup

Try it out by installing our kustomized stack:

```
kubectl apply -k github.com/observeinc/manifests/stack
kubectl -n observe create secret generic credentials \
        --from-literal=OBSERVE_CUSTOMER=${OBSERVE_CUSTOMER?} \
        --from-literal=OBSERVE_TOKEN=${OBSERVE_TOKEN?}
```

This will create an `observe` namespace for you and start collecting Kubernetes state, logs and metrics.

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

- `github.com/observeinc/stack/xs` - intended to run on small clusters such as development environments, where resources are scarce and reliability is less of a concern
- `github.com/observeinc/stack/m` - the default sizing, intended to run on clusters with hundreds of pods. Start here and adjust up or down accordingly.
- `github.com/observeinc/stack/l` - used for similar sized clusters as `m`, but with higher throughput in logs, metrics or events. This may be due to verbose logging, high cardinality metrics or frequent cluster reconfiguration.
- `github.com/observeinc/stack/xl` - intended to run on large clusters with 100+ nodes. Collection is preferentially performed using daemonsets rather than deployments.

Resource limits for each sizing is as follows:

|         |      xs      |       m       |       l       |       xl      |
|--------:|:------------:|:-------------:|:-------------:|:-------------:|
|  events |  20m<br>64Mi |  50m<br>256Mi |   200m<br>1Gi |   400m<br>2Gi |
|   logs* |  10m<br>64Mi | 100m<br>128Mi | 200m<br>192Mi | 500m<br>256Mi |
| metrics | 50m<br>256Mi |   250m<br>2Gi | 500m<br>4Gi   |  200m*<br>1Gi |

\* run as daemonset

# Configuration

You can override any individual configuration element by creating a new
kustomized manifest with our kustomized directory as a base.

The following example creates a new directory with `kustomization.yaml` set to
override the `FB_DEBUG` variable in the fluent-bit environment variable
configmap:

```
EXAMPLE_DIR=$(mktemp -d)

cat <<EOF >$EXAMPLE_DIR/kustomization.yaml
bases:
  - github.com/observeinc/manifests/stack?ref=main

configMapGenerator:
  - name: fluent-bit-env
    behavior: merge
    literals:
      - FB_DEBUG=true
EOF

kubectl apply -k $EXAMPLE_DIR
```

You can version control your kustomized directory while tracking upstream changes through the use of branch tags.

# Pruning and deletion

All Kubernetes resources installed through this repo will have an
`observeinc.com/component` label. You can therefore use this label for pruning an existing install:

```
kubectl apply -k github.com/observeinc/manifests/stack --prune -l observeinc.com/component
```

To delete an existing install, just use `delete -k`:

```
kubectl delete -k github.com/observeinc/manifests/stack
```

# Release cycle

Releases are automatically cut on a weekly basis on Tuesdays. Release tags
follow [Semantic versioning](https://semver.org/). Bugfixes increment the patch
version number, whereas new features increment the minor version. In the
absence of bugfixes or features, no release is cut.
