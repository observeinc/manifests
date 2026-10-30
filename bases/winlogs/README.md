# Windows logs collection

> **Maintenance status:** this base is no longer updated and will not get new releases, including for security advisories that affect the `fluent/fluentd:v1.14.6-windows-20H2-1.0` image it deploys. That image is built on Windows Server 20H2 and Ruby 2.7, which are both out of support, and there is no fixed release on that line. The [Observe agent Helm chart](https://github.com/observeinc/helm-charts/tree/main/charts/agent) does not run on Windows nodes, so there is no direct replacement for this base.
