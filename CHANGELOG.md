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



# [0.9.0](https://github.com/observeinc/manifests/compare/v0.8.1...v0.9.0) (2022-04-19)


### Bug Fixes

* add example for tweaking limits ([b989360](https://github.com/observeinc/manifests/commit/b9893604626d803932bb89218af555000dfed0ab))
* adjust xl limits ([#33](https://github.com/observeinc/manifests/issues/33)) ([e8cfa26](https://github.com/observeinc/manifests/commit/e8cfa263c74dd8b30512c59df1da022fa07c063e))


### Features

* bump grafana-agent to v0.24.1 ([#34](https://github.com/observeinc/manifests/issues/34)) ([ce3f553](https://github.com/observeinc/manifests/commit/ce3f5530c679fc9e8ee4ae306b4baf770768b4ea))
* bump kube-state-events to 0.8.0 ([#35](https://github.com/observeinc/manifests/issues/35)) ([a7da03a](https://github.com/observeinc/manifests/commit/a7da03abdfe73e2e1929dd5e423a257b609e5c2c))
* **metrics:** allow signalling pod should not be scraped ([#36](https://github.com/observeinc/manifests/issues/36)) ([1bbd432](https://github.com/observeinc/manifests/commit/1bbd432a551b2f42cc4cb58fe84c9a1edbe95f63))



## [0.8.1](https://github.com/observeinc/manifests/compare/v0.8.0...v0.8.1) (2022-04-06)


### Bug Fixes

* bump fluent-bit to 1.8.15 ([#32](https://github.com/observeinc/manifests/issues/32)) ([eb022ba](https://github.com/observeinc/manifests/commit/eb022ba334fcca410207331430e7cd077241f515))



# [0.8.0](https://github.com/observeinc/manifests/compare/v0.7.1...v0.8.0) (2022-04-05)


### Bug Fixes

* add logging exporter ([#30](https://github.com/observeinc/manifests/issues/30)) ([04648fa](https://github.com/observeinc/manifests/commit/04648fa3f81f1b9a05f7986101a0685d8209fe1e))
* bump otel-collector-contrib to 0.48.0 ([#29](https://github.com/observeinc/manifests/issues/29)) ([0c6c3d2](https://github.com/observeinc/manifests/commit/0c6c3d2b32d4d548e099b01ae7622200c81d6540))
* move extras/openshift to examples/openshift ([#18](https://github.com/observeinc/manifests/issues/18)) ([f06361c](https://github.com/observeinc/manifests/commit/f06361c02f1bdde447a364930757aecd8ded3126))
* **traces:** add clusterUid as resource attribute ([#22](https://github.com/observeinc/manifests/issues/22)) ([f9e3962](https://github.com/observeinc/manifests/commit/f9e3962369d6bafafafa6355d9d208f6f2388475))
* **traces:** remove node filter for k8sattributesprocessor ([#31](https://github.com/observeinc/manifests/issues/31)) ([f32d6d3](https://github.com/observeinc/manifests/commit/f32d6d3027fd0abe89d7ffdc0422b91838d3734e))
* update metrics limits to match docs. ([#27](https://github.com/observeinc/manifests/issues/27)) ([4e15b3e](https://github.com/observeinc/manifests/commit/4e15b3e107ec1b590b7471d17b2369f78c780234))


### Features

* add k8sattribute to otel-collector ([#25](https://github.com/observeinc/manifests/issues/25)) ([75e5086](https://github.com/observeinc/manifests/commit/75e508612b76cbda0dec8adb92afaab580608a12))
* add zipkin handling to otel-collector ([#28](https://github.com/observeinc/manifests/issues/28)) ([deee5bb](https://github.com/observeinc/manifests/commit/deee5bbdeae9d14fcd77f58cba1b72d878d47e73))
* migrate traces to use daemonset ([#24](https://github.com/observeinc/manifests/issues/24)) ([8d0514b](https://github.com/observeinc/manifests/commit/8d0514b3e9bae8aec68ca8b1035bf330219c87eb))
* scrape otel-collector metrics ([#26](https://github.com/observeinc/manifests/issues/26)) ([8ef4dc5](https://github.com/observeinc/manifests/commit/8ef4dc5c7400a366509000e135657e53b746467d))
* **traces:** bump otel-collector-contrib to 0.47.0 ([#23](https://github.com/observeinc/manifests/issues/23)) ([7b44396](https://github.com/observeinc/manifests/commit/7b443961ab3b647aa4e26c3d0bead094d4f14cf0))



