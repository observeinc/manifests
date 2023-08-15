# Metrics collection

Our general collection posture is to collect as much information as possible out of the box while still being able to install successfully in large environments.

In some cases this approach may lead to the collection of more metrics than
intended. Given there is no concept of metrics “verbosity” which operators can
toggle on their end, we provide multiple levers for tuning what metrics get
emitted to Observe.

# Sources of metrics in Kubernetes

We have four "jobs" in our `grafana-agent` configuration to collect metrics:

- `integrations/kubernetes/pods` scrapes metrics from pods using service discovery. This is typically the main driver of unexpected costs.
- `integrations/kubernetes/cadvisor` collects CAdvisor metrics from the Kubelet agent. This endpoint is not portable across OSes, but it is the richest source of info on system metrics. The number of metrics emitted by this job is proportional to the size of the infrastructure being monitored (i.e. number of containers, pods, nodes)
- `integrations/kubernetes/resource` scrapes from the newer endpoint in Kubelet. It’s meant to be a platform agnostic way of tracking system metrics, but has less information than CAdvisor.
- `integrations/kubernetes/kubelet` collects metrics from the legacy endpoint in Kubelet agent. This endpoint is on the way out - it has less information than CAdvisor, and is superseded by `integrations/kubernetes/resource`.

# Filtering metrics on collection side

We use environment variables to control what we collect from each of these jobs.

The quickest way of providing overrides is creating a `env-overrides` configmap in the `observe` namespace, and then restarting the affected service, e.g:

```bash
echo "FB_DEBUG=true" >> example.env
kubectl create configmap -n observe env-overrides --from-env-file example.env
kubectl restart rollout -n observe deployment observe-metrics
```

The following environment variables are available for controlling collection:

### PROM_SCRAPE_{JOB}_ACTION

This variable determines whether we collect any data for the job. We can either `keep` or `drop` the “targets” from which metrics will be collected. By default, we proceed with collection from the first three jobs and ignore the latter:

```bash
- PROM_SCRAPE_CADVISOR_ACTION=keep
- PROM_SCRAPE_POD_ACTION=keep
- PROM_SCRAPE_RESOURCE_ACTION=keep
- PROM_SCRAPE_KUBELET_ACTION=drop
```

### PROM_SCRAPE_{JOB}_METRIC_{ACTION}_REGEX

For each job, we allow users to provide an exclusion and inclusion regex on metric names.

Note that each of the "drop" and "keep" actions are performed for each set
of metrics. For a metric to be included, it must both *not* match the
"drop" regex, as well as match the "keep" regex.

See https://prometheus.io/docs/prometheus/latest/configuration/configuration for details.

The exact relabeling magic is contained here:

```yaml
metric_relabel_configs:
    - action: drop
        regex: ${PROM_SCRAPE_KUBELET_METRIC_DROP_REGEX}
        source_labels:
            - __name__
    - action: keep
        regex: ${PROM_SCRAPE_KUBELET_METRIC_KEEP_REGEX}
        source_labels:
            - __name__
```

The defaults for each job are as follows:

```bash
- PROM_SCRAPE_CADVISOR_METRIC_DROP_REGEX=container_(network_tcp_usage_total|network_udp_usage_total|tasks_state|cpu_load_average_10s)
- PROM_SCRAPE_CADVISOR_METRIC_KEEP_REGEX=container_(cpu_.*|spec_.*|memory_.*|network_.*|fs_.*|file_descriptors)|machine_(cpu_cores|memory_bytes)
- PROM_SCRAPE_KUBELET_METRIC_DROP_REGEX=
- PROM_SCRAPE_KUBELET_METRIC_KEEP_REGEX=(.*)
- PROM_SCRAPE_POD_METRIC_DROP_REGEX=.*bucket
- PROM_SCRAPE_POD_METRIC_KEEP_REGEX=(.*)
- PROM_SCRAPE_RESOURCE_METRIC_DROP_REGEX=
- PROM_SCRAPE_RESOURCE_METRIC_KEEP_REGEX=(.*)
```

To restrict CAdvisor metrics to the set used by the default Kubernetes board, see the commented line in kustomization.yaml.
For Pod Metrics we drop histogram data because they represent a large proportion of metrics which historically we could not make use of. These defaults may be revisited.

### PROM_SCRAPE_POD_NAMESPACE_{ACTION}_REGEX

For metrics collected from pods in particular, we can further filter by namespace:

```yaml
- PROM_SCRAPE_POD_NAMESPACE_DROP_REGEX=(.*istio.*|.*ingress.*|kube-system)
- PROM_SCRAPE_POD_NAMESPACE_KEEP_REGEX=(.*)
```

By default we ignore anything with `istio` and `ingress` because both istio and nginx tend to export a tremendous amount of metrics which are more easily extracted out of logs. We ignore `kube-system` because it typically has third party software with a lot of metrics, e.g. kube-state-metrics.

# Managing pod service discovery

The `integrations/kubernetes/pods` job uses service discovery to determine what pods to scrape. If you want to expose Prometheus metrics from your pod, you have two options:

- set the port using the `prometheus.io/port` annotation. This method has the disadvantage that it can only surface one HTTP endpoint for collection.
    ```
     annotations:
       prometheus.io/port: "9999"
    ```
- expose the metrics endpoint through a port with a name matching a configured regex (`.*metrics` by default). For example:
    ```yaml
    - PROM_SCRAPE_POD_PORT_KEEP_REGEX=.*metrics
    ```
    ```yaml
    ports:
    - containerPort: 9999
      name: metrics
    - containerPort: 12345
      name: sidecar-metrics
    ```

If you don’t want to scrape a particular pod, you can set either of the following annotations:

- `prometheus.io/scrape=false`: this will likely influence all other agents scraping for data.
- `observeinc.com/scrape=false`: this option is only used by Observe's collection process.
