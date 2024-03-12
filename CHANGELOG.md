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



## [0.35.3](https://github.com/observeinc/manifests/compare/v0.35.2...v0.35.3) (2024-01-30)


### Bug Fixes

* **deps:** Update fluenbit and grafana agent ([#147](https://github.com/observeinc/manifests/issues/147)) ([ff19f22](https://github.com/observeinc/manifests/commit/ff19f2271e2e3016907ff1fbd0c365268a07d387))
* **logs:** add FB_IGNORE_OLDER ([#150](https://github.com/observeinc/manifests/issues/150)) ([daa2eee](https://github.com/observeinc/manifests/commit/daa2eee14595d7dc2e38d5b60181f8b9f48b8446))
* **metrics:** bump cadvisor interval to 60s ([#148](https://github.com/observeinc/manifests/issues/148)) ([8646829](https://github.com/observeinc/manifests/commit/8646829b76127c076ee861cb7ab9373cbc8f3fc9))
* **traces:** bump otel-collector-contrib to 0.93.0 ([07c222e](https://github.com/observeinc/manifests/commit/07c222ebb6088480308688c199723f314098892f))



## [0.35.2](https://github.com/observeinc/manifests/compare/v0.35.1...v0.35.2) (2024-01-16)


### Bug Fixes

* bump grafana agent and otel versions ([72f8608](https://github.com/observeinc/manifests/commit/72f8608231f73736e4f8d9fd728f2bcc2404ac46))



