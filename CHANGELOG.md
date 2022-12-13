# [0.23.0](https://github.com/observeinc/manifests/compare/v0.22.0...v0.23.0) (2022-12-13)


### Features

* **events:** upgrade kube-state-events to v0.9.1 ([#93](https://github.com/observeinc/manifests/issues/93)) ([5af20b9](https://github.com/observeinc/manifests/commit/5af20b9da76ab465e5e8ddae75de2abf89a53b12))



# [0.22.0](https://github.com/observeinc/manifests/compare/v0.21.0...v0.22.0) (2022-12-06)


### Bug Fixes

* **logs:** bump fluentbit to 1.9.10 ([#87](https://github.com/observeinc/manifests/issues/87)) ([a2ddecf](https://github.com/observeinc/manifests/commit/a2ddecfe168ba072b78f253bbf13fd99490c57b9))
* **metrics:** export prom metrics from grafana-agent ([#88](https://github.com/observeinc/manifests/issues/88)) ([9a3c33f](https://github.com/observeinc/manifests/commit/9a3c33faab57a48c73e495eed65aceb308d6b0eb))


### Features

* **logs:** allow disabling inotify_watcher ([#91](https://github.com/observeinc/manifests/issues/91)) ([ff3ecfc](https://github.com/observeinc/manifests/commit/ff3ecfcfde96e2db436bc6175a05f3ebf90874e5))
* **metrics:** protect against cardinality explosion ([#89](https://github.com/observeinc/manifests/issues/89)) ([fa12f7a](https://github.com/observeinc/manifests/commit/fa12f7a1cf474e35aae75fe0da35847f2a45e743))



# [0.21.0](https://github.com/observeinc/manifests/compare/v0.20.0...v0.21.0) (2022-11-15)


### Bug Fixes

* **traces:** reintroduce observe- prefix ([#84](https://github.com/observeinc/manifests/issues/84)) ([094cd2a](https://github.com/observeinc/manifests/commit/094cd2a1e2b6d2880f67a2caea097a41658d0d78))
* **traces:** remove superfluous prefixing ([#86](https://github.com/observeinc/manifests/issues/86)) ([073ab25](https://github.com/observeinc/manifests/commit/073ab258e5439f410183a8cabcda758416e013b5)), closes [#84](https://github.com/observeinc/manifests/issues/84)


### Features

* **metrics:** bump grafana-agent to 0.28.1 ([#85](https://github.com/observeinc/manifests/issues/85)) ([e517434](https://github.com/observeinc/manifests/commit/e5174347e4d27113c3d4b8ea73d7cd004fd3af45))



# [0.20.0](https://github.com/observeinc/manifests/compare/v0.19.0...v0.20.0) (2022-11-08)


### Bug Fixes

* **traces:** xl stack now points to bases/traces/otel/l for traces ([c3d1dd2](https://github.com/observeinc/manifests/commit/c3d1dd2fbfbd7cdcb66f0dd016c20d97eb2dcb5c))


### Features

* **traces:** add deployment for stack/otel/l ([76d6226](https://github.com/observeinc/manifests/commit/76d6226852393fa1f37eb4db89b21a31304d9e15))



# [0.19.0](https://github.com/observeinc/manifests/compare/v0.18.0...v0.19.0) (2022-10-18)


### Features

* **traces:** bump otel-collector-contrib to 0.61.0 ([278dfb8](https://github.com/observeinc/manifests/commit/278dfb879e3d83c9f27ce355d4c0137f3c823cbf))



