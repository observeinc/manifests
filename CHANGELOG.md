# [0.35.0](https://github.com/observeinc/manifests/compare/v0.34.0...v0.35.0) (2023-12-21)


### Bug Fixes

* bump kube-state-events to 0.11.1 ([#143](https://github.com/observeinc/manifests/issues/143)) ([570249f](https://github.com/observeinc/manifests/commit/570249f2268b6b75facfd381a896ee90f4c0d264))
* **traces:** update otlphttp endpoint to v2 ([#141](https://github.com/observeinc/manifests/issues/141)) ([6e3a091](https://github.com/observeinc/manifests/commit/6e3a09185d9c052dc4a8729cbd5d798c61519c52))


### Features

* **traces:** update otel-collector-contrib to 0.91.0 ([cffe059](https://github.com/observeinc/manifests/commit/cffe059a898a7104b8b0327521f4efa78d0ddc78))



# [0.34.0](https://github.com/observeinc/manifests/compare/v0.33.0...v0.34.0) (2023-12-19)


### Bug Fixes

* **traces:** remove inadvertent commit ([5c0668c](https://github.com/observeinc/manifests/commit/5c0668c62e3335fa6be83b008510e8290d0c19fd))
* **traces:** update otlphttp endpoint to v2 ([ae7f51d](https://github.com/observeinc/manifests/commit/ae7f51d3b05cdf9ad9294de190ffb75a0f9a3cfa))


### Features

* bump grafana-agent, otel-collector-contrib ([#140](https://github.com/observeinc/manifests/issues/140)) ([c4ae170](https://github.com/observeinc/manifests/commit/c4ae17008535fca0a28f68dac3c928ae9147955f))
* bump test versions ([#138](https://github.com/observeinc/manifests/issues/138)) ([af2758f](https://github.com/observeinc/manifests/commit/af2758f5296c0f39b73903cc60746802b4771f93))
* cleanup deprecated references in kustomize ([#137](https://github.com/observeinc/manifests/issues/137)) ([54523e9](https://github.com/observeinc/manifests/commit/54523e96b5e8c4bb842428f641fb96ce3dab1d01))
* **metrics:** per job scrape interval, tweak defaults. ([#139](https://github.com/observeinc/manifests/issues/139)) ([26c8327](https://github.com/observeinc/manifests/commit/26c8327d8d74f03f38cba255c7c552cf99072be3))



# [0.33.0](https://github.com/observeinc/manifests/compare/v0.32.0...v0.33.0) (2023-11-28)


### Features

* **deps:** update grafana-agent to 0.38.0 ([#136](https://github.com/observeinc/manifests/issues/136)) ([e0da7d4](https://github.com/observeinc/manifests/commit/e0da7d466a42e1c20dbf4732562304500d21e8b3))



# [0.32.0](https://github.com/observeinc/manifests/compare/v0.31.1...v0.32.0) (2023-11-22)


### Features

* **traces:** use memory limiter percentages ([#135](https://github.com/observeinc/manifests/issues/135)) ([dd01030](https://github.com/observeinc/manifests/commit/dd010306abb772d9606185aeea683c49825af5db))



## [0.31.1](https://github.com/observeinc/manifests/compare/v0.31.0...v0.31.1) (2023-11-16)


### Bug Fixes

* **traces:** extract k8s.cluster.uid through k8sattributes ([9f385e9](https://github.com/observeinc/manifests/commit/9f385e927e56a45202912b27d1800d2c4bf17bf4))
* **traces:** split pod_association rules and remove node filtering in k8sattributes processor ([66b73b0](https://github.com/observeinc/manifests/commit/66b73b02cf693a4559226b56e0183c3ddf3295fc))



