# [0.12.0](https://github.com/observeinc/manifests/compare/v0.11.2...v0.12.0) (2022-05-31)


### Features

* **winlog:** adding Windows support ([582b250](https://github.com/observeinc/manifests/commit/582b250cdf563f8a29cd92f87a2f3febac5e7013))



## [0.11.2](https://github.com/observeinc/manifests/compare/v0.11.1...v0.11.2) (2022-05-24)


### Bug Fixes

* bump kube-state-events to 0.8.2 ([#46](https://github.com/observeinc/manifests/issues/46)) ([84b1498](https://github.com/observeinc/manifests/commit/84b1498faa63358cade7a827f6401d5a91180d17))
* **metrics:** bump grafana-agent to 0.24.2 ([#45](https://github.com/observeinc/manifests/issues/45)) ([859249e](https://github.com/observeinc/manifests/commit/859249e63d9431aa51ae1840a6d50ecbdcad894e))



## [0.11.1](https://github.com/observeinc/manifests/compare/v0.11.0...v0.11.1) (2022-05-17)


### Bug Fixes

* avoid scheduling events and metrics on windows ([188ea60](https://github.com/observeinc/manifests/commit/188ea6007eb713c37ff7c089fee84a8b468e4a77))
* avoid scheduling on windows nodes ([9ec0b17](https://github.com/observeinc/manifests/commit/9ec0b1790b41b97f61d6c5b0b42eaf899fb4072a))



# [0.11.0](https://github.com/observeinc/manifests/compare/v0.10.0...v0.11.0) (2022-05-03)


### Bug Fixes

* **events:** bump kube-state-events to 0.8.1 ([#42](https://github.com/observeinc/manifests/issues/42)) ([1d818a7](https://github.com/observeinc/manifests/commit/1d818a78a18b45684e8f9e2c9c6a5de5c3afd9f0))


### Features

* **logs:** bump fluent-bit to 1.9.3 ([a139026](https://github.com/observeinc/manifests/commit/a139026451b457ac12bf86eaa2fe66571ec81b4a))
* **traces:** bump otel-collector-contrib to 0.50.0 ([#41](https://github.com/observeinc/manifests/issues/41)) ([05924b1](https://github.com/observeinc/manifests/commit/05924b1b357d11afa2a2650b3cd781410e6c8301))



# [0.10.0](https://github.com/observeinc/manifests/compare/v0.9.0...v0.10.0) (2022-04-26)


### Bug Fixes

* reorder envFrom ([#39](https://github.com/observeinc/manifests/issues/39)) ([f62eabe](https://github.com/observeinc/manifests/commit/f62eabe2e5073ea80a9d702bf40bb974b1271d76))


### Features

* allow overriding environment variables with configMap ([#38](https://github.com/observeinc/manifests/issues/38)) ([c06c41e](https://github.com/observeinc/manifests/commit/c06c41e96fe7ec04ec715a6b612aab1e2ea966b7))
* drop unused cadvisor metrics, make configurable ([#37](https://github.com/observeinc/manifests/issues/37)) ([d40b22c](https://github.com/observeinc/manifests/commit/d40b22cf883549274b69982fe66807f8210c4d13))
* **logs:** support wildcard matching in output ([#40](https://github.com/observeinc/manifests/issues/40)) ([3bba9c8](https://github.com/observeinc/manifests/commit/3bba9c852b83da616eaa4837979c5d3a8732933e))



