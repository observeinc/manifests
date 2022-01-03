# Observe kustomize manifests

> **WARNING**: Use at your own peril, we are still iterating towards a 1.0.0 release

This repository contains kustomized Kubernetes manifests supported by Observe.
These are intended as a way of quickly ingesting Kubernetes data into your
Observe instance.

# Quick setup

Try it out by installing our kustomized stack:

```
kubectl apply -k github.com/observeinc/manifests/stack
kubectl -n observe create secret generic credentials \
        --from-literal=customer=${OBSERVE_CUSTOMER?} \
        --from-literal=token=${OBSERVE_TOKEN?}
```

This will create an `observe` namespace for you and start collecting Kubernetes state, logs and metrics.

# Components

We provide three "base" components:

- `bases/events` - responsible for collecting Kubernetes state using `kube-state-events`
- `bases/logs` - responsible for collecting container logs using `fluent-bit`
- `bases/metrics` - responsible for collecting container logs using `grafana-agent`

We compose these base layers into overlays. Our default `stack` overlay
collects events, logs and metrics.

# Sizing

By default, we attempt to choose defaults which have a wide operating
range. However, some clusters will inevitably fall outside this range. We
provide additional configurations that are more appropriate for these extremes:

- `github.com/observeinc/stack/xs` - intended to run on small clusters such as development environments, where resources are scarce and reliability is less of a concern
- `github.com/observeinc/stack/xl` - intended to run on large clusters with 100+ nodes

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
