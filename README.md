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

# How things work

Kubernetes supports four "base" layers:

- `bases/events` - responsible for collecting Kubernetes state using `kube-state-events`
- `bases/logs` - responsible for collecting container logs using `fluent-bit`
- `bases/metrics` - responsible for collecting container logs using `grafana-agent`
- `bases/traces` - responsible for collecting traces using `otel-collector`

We compose these layers into default stacks (`overlays` in kustomize
nomenclature). Our default stack defined in [here] collects events, logs and
metrics.

# Sizing

By default, we attempt to choose sane defaults which have a wide operating
range. However, some clusters will either be too large for our default
manifest, or just too small. We provide additional configurations that are more
appropriate for these extremes:

- `github.com/observeinc/stack/xs` - intended to run on small clusters such as development environments, where resources are scarce and reliability is less of a concern
- `github.com/observeinc/stack/xl` - intended to run on large clusters with 100+ nodes

