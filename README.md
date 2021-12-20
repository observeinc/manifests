# Observe kustomize manifests

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

# Layout 

We provide four "base" layers:

- `bases/events` - responsible for collecting Kubernetes state using `kube-state-events`
- `bases/logs` - responsible for collecting container logs using `fluent-bit`
- `bases/metrics` - responsible for collecting container logs using `grafana-agent`
- `bases/traces` - responsible for collecting traces using `otel-collector`

We compose these layers into default stacks (`overlays` in kustomize
nomenclature). Our default stack defined in [here] collects events, logs and
metrics.

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
DEMO_HOME=$(mktemp -d)

cat <<EOF >$DEMO_HOME/kustomization.yaml
bases:
  - ssh://git@github.com/observeinc/manifests/stack?ref=main

configMapGenerator:
  - name: fluent-bit-env
    behavior: merge
    literals:
      - FB_DEBUG=true
EOF

kubectl apply -k $DEMO_HOME
```

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
