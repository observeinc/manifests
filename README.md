# Observe kustomize manifests

This repository contains _kustomized_ Kubernetes manifests supported by [Observe](https://www.observeinc.com/)
These are intended as a way of quickly start ingesting data into Observe.

# Quick setup

You can install our kustomize stack directly using `kubectl`: Kustomize is built into kubectl, from version 1.14.[*](https://cloud.google.com/anthos-config-management/docs/concepts/kustomize)
<!-- TODO: Support Version <1.14 we have to -->

## Observe Stack

```
kubectl apply -k github.com/observeinc/manifests//stack
```

This will create an `observe` namespace for you and start collecting Kubernetes state, logs and metrics.
To send data to Observe you must create a secret containing your an Observe Datastream token. A token can be generated from from an Observe app or [datastream](https://docs.observeinc.com/en/latest/content/data-ingestion/datastreams.html#create-a-token).

```
OBSERVE_CUSTOMER='observe_customer_id'
OBSERVE_TOKEN='some_token'
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

## Next: [Install Otel](#traces)

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

|         |     `xs`     |      `m`      |      `l`      |     `xl`      |
|--------:|:------------:|:-------------:|:-------------:|:-------------:|
|  events | 20m<br>64Mi  | 50m<br>256Mi  |  200m<br>1Gi  |  400m<br>2Gi  |
|   logs* | 10m<br>64Mi  | 100m<br>128Mi | 200m<br>192Mi | 500m<br>256Mi |
| metrics | 50m<br>256Mi |  250m<br>2Gi  |  500m<br>4Gi  | 200m*<br>1Gi  |

\* run as daemonset

# Traces

Support for trace collection is available with the OpenTelemetry App installed in your Observe account. After installing the App, you will need to configure an otel-collector 'gateway' to send data to Observe. 

Observe provides an `otel` Kustomize stack to streamline creating the resources needed to report your spans to Observe. The Daemonset and Deployments for these are are based on standard deployment of opentelementry adapted from [OpenTelemetry-helm-charts](https://github.com/open-telemetry/opentelemetry-helm-charts/tree/main/charts/opentelemetry-collector/examples)
## App Token Secret

Observe's OpenTelemetry Collector requires an OBSERVE_TOKEN and OBSERVE_CUSTOMER environment variables provided by the credentials secret that is created as part of the [OpenTelemetry Observe App](https://docs.observeinc.com/en/latest/content/integrations/otel/opentelemetry.html). For more information on how this token works, please consider [Observe's Datastream Documentation](https://docs.observeinc.com/en/latest/content/data-ingestion/datastreams.html#create-a-token)

**It's strongly recommended use a different 'Bearer' token than the one created for the credentials in [Observe Stack](#observe-stack).** After you Generate a new OBSERVE_TOKEN for the OpenTelemetry App you need to add it as a k8s secret resource called `otel-credentials`

```
OBSERVE_CUSTOMER='observe_customer_id'
OBSERVE_TOKEN='connection_token_for_otel_app'
kubectl -n observe create secret generic otel-credentials \
        --from-literal=OBSERVE_CUSTOMER=${OBSERVE_CUSTOMER?} \
        --from-literal=OBSERVE_TOKEN=${OBSERVE_TOKEN?}
```

**Note:** OpenTelemetry Collector Pods will not start without expected secret

### Update Note:

Updating from this manifest after _November 11, 2022_ will *Change the secret mounted by the collector* from `credentials` to `otel-credentials`. This _**Requires**_ an observe token from the OpenTelemetry Observe App to prevent large Cost Spike and undefined behavior.

## Otel stack
For general application you can use the default Observe Kustomize manifests which provides a daemonset instance of opentelemetry-collector designed for small (<100 nodes) clusters

```
kubectl apply -k github.com/observeinc/manifests//stack/otel
```

You can also use specific sizings:

- `kubectl apply -k github.com/observeinc/manifests/stack/otel/xs`
- `kubectl apply -k github.com/observeinc/manifests/stack/otel/m`
- `kubectl apply -k github.com/observeinc/manifests/stack/otel/l`
- `kubectl apply -k github.com/observeinc/manifests/stack/otel/xl`

The respective opentelemetry-collector container for each size:

|     | `xs`  | `m` | `l` | `xl` |
| --: | :---: | :-: | :-: | :--: |
| traces* | 50m<br>128Mi<br>(Daemonset) | 250m<br>256Mi<br>(Daemonset) | 250m<br>256Mi<br>(deployment replicas: 10) | 250m<br>256Mi | points to l 

Once installed, traces can be sent to the local collector running in k8s over GRPC on 
`observe-traces.observe.svc.cluster.local:4317`.

**NOTE** When migrating from _s_ or _m_ to _l_, ensure that you remove the previous opentelemetry-collector daemonset

```
$ kubectl -n observe delete daemonset.apps traces
```

## Inherit from Kustomize Observe stack manifests

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

or, alternatively, you can build using your specific `kustomize` version:

```
kustomize build $EXAMPLE_DIR
```

It's recommended you version control your kustomized directory while tracking upstream changes through the use of branch tags.

## Using an override configMap

Alternatively, you can create a configmap in the `observe` namespace containing
overrides for each pod. Similar to the previous example, you can override the environment for _all Observe pods_ by creating an `env-overrides` files.

```
echo "FB_DEBUG=true" >> example.env
kubectl create configmap -n observe env-overrides --from-env-file example.env
```

Unlike the kustomize method, configuration changes are not picked up
automatically. You must restart the relevant pods to pick up the new environment variables. You can do this by restarting the daemonset(s) and deployment(s) in the `observe` namespace

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

