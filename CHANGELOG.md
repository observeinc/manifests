## [1.1.2](https://github.com/observeinc/manifests/compare/v1.1.1...v1.1.2) (2024-03-20)


### Bug Fixes

* **metrics:** only scrape init containers if port set ([#165](https://github.com/observeinc/manifests/issues/165)) ([e794a3e](https://github.com/observeinc/manifests/commit/e794a3e285e5bf16e260ab6c126bbd0a829a2d91))



## [1.1.1](https://github.com/observeinc/manifests/compare/v1.1.0...v1.1.1) (2024-03-19)


### Bug Fixes

* **deps:** Update dependencies ([#163](https://github.com/observeinc/manifests/issues/163)) ([593c34f](https://github.com/observeinc/manifests/commit/593c34feb41c74cc810f3244f78ad888db6d1ac8))



# [1.1.0](https://github.com/observeinc/manifests/compare/v1.0.1...v1.1.0) (2024-03-12)


### Features

* update grafana-agent, fluent-bit ([#162](https://github.com/observeinc/manifests/issues/162)) ([5bbee29](https://github.com/observeinc/manifests/commit/5bbee29b954759ea15ca8051bcafa30393d98c91))



## [1.0.1](https://github.com/observeinc/manifests/compare/v1.0.0...v1.0.1) (2024-02-27)


### Bug Fixes

* **deps:** bump grafana-agent and otel-collector-contrib ([2df306a](https://github.com/observeinc/manifests/commit/2df306a2083216580c1fc2b23139808144bde40c))



# [1.0.0](https://github.com/observeinc/manifests/compare/v0.35.3...v1.0.0) (2024-02-05)


### Bug Fixes

* **metrics:** bump global scrape interval to 60s ([90864a9](https://github.com/observeinc/manifests/commit/90864a931918a6f6ad7c7125d2e6046681061abb))


* fix(metrics)!: Stop collecting container_fs_xxx metrics to reduce a data volume and make the data collection opted-in ([a530c66](https://github.com/observeinc/manifests/commit/a530c6641b6a3a4cce7c798970218459def324a5))


### BREAKING CHANGES

* PROM_SCRAPE_POD_ACTION was previously set to keep but is changed to drop to reduce a data volume and make the data collection of pod metrics opted-in.
https://docs.observeinc.com/en/latest/content/integrations/kubernetes/collecting_pod_metrics_cadvisor_metrics.html



