# [0.4.0](https://github.com/observeinc/manifests/compare/v0.3.0...v0.4.0) (2022-02-14)


### Bug Fixes

* bump kube-state-events to 0.6.2 ([67dc874](https://github.com/observeinc/manifests/commit/67dc874532dc337ace4a18952959246b10f151a6))
* revise `m` sizing ([9c0a683](https://github.com/observeinc/manifests/commit/9c0a68386b1bf47092d63403a84cf47e9f7527d2))


### Features

* add `l` stack ([fda45b5](https://github.com/observeinc/manifests/commit/fda45b5406cc982f8fabb5b8995c1a15ffc0c943))
* bump fluentbit to v1.8.12 ([cd05628](https://github.com/observeinc/manifests/commit/cd05628edfd7558b2c51f99a5072795b2c5b09bf))
* bump grafana-agent to v0.22.0 ([f2f6638](https://github.com/observeinc/manifests/commit/f2f6638475c250598f9eea0deee76299803e19ff))
* update limits ([422bb71](https://github.com/observeinc/manifests/commit/422bb71e218d99b3d8b8c7bda56c9ecb517094b2))



# [0.3.0](https://github.com/observeinc/manifests/compare/v0.2.0...v0.3.0) (2022-01-21)


### Bug Fixes

* add .gitignore ([3e153c7](https://github.com/observeinc/manifests/commit/3e153c71ddb27d52975c2ef8eaa72e9d5012b42d))
* adjust memory resource for events ([757804e](https://github.com/observeinc/manifests/commit/757804e0bc135e1ebed394a3a69d3185775c9c30))
* adjust prom metrics discovery ([b5769d4](https://github.com/observeinc/manifests/commit/b5769d4faa938f88d92777ebac0f1b37cc73bf0f))
* adjust scripts/test.sh to use new credentials ([06f871f](https://github.com/observeinc/manifests/commit/06f871f248f5670d2ed1a3885398324b46adf456))
* bump kube-state-events to 0.6.1 ([90aa4a0](https://github.com/observeinc/manifests/commit/90aa4a089208ab40f32632b2a8c4f8e943b69459))
* do not schedule daemonsets on fargate ([5a9bd0e](https://github.com/observeinc/manifests/commit/5a9bd0e0fb6590b6496f9710b64e132c8477dddf))
* improvements to grafana-agent config ([dd6e8e9](https://github.com/observeinc/manifests/commit/dd6e8e9318771acbb1f5b9e40ad8eeafefa0695b))
* **metrics:** reduce mem usage ([40312ab](https://github.com/observeinc/manifests/commit/40312ab42581852988375c8a20ba04cea56dc6a4))
* **metrics:** support both port and annotation scraping ([36285d9](https://github.com/observeinc/manifests/commit/36285d9f1f0e9940bf22665ef3b5d32f64a2f1a6))
* **metrics:** tweak xl resource limits and requests ([891246b](https://github.com/observeinc/manifests/commit/891246b621166ea3628d7754aa1bb02252f110e1))
* remove apiserver metrics collection for now ([04cde2e](https://github.com/observeinc/manifests/commit/04cde2e985c417fca77da23e6b8958aa64c3ef23))


### Features

* add prom job to pull kubelet resource metrics ([8cc222e](https://github.com/observeinc/manifests/commit/8cc222ebc8685af602bc292ec7cb9f0cc4cdb634))
* allow setting OBSERVE_COLLECTOR_* in credentials ([a8d225d](https://github.com/observeinc/manifests/commit/a8d225da307c0b97004a5446e8228a9b6c1d7c1f))
* **metrics:** add daemonset mode for xl ([0b01298](https://github.com/observeinc/manifests/commit/0b01298153b6b971a82a975abf1b56575e223e7c))
* **prometheus:** port-based service discovery ([13dc600](https://github.com/observeinc/manifests/commit/13dc6003dd2da9a8827d83d62a0282262b7953c7))



# [0.2.0](https://github.com/observeinc/manifests/compare/v0.1.0...v0.2.0) (2022-01-04)


### Bug Fixes

* remove fluentbit multiline parser ([b414109](https://github.com/observeinc/manifests/commit/b4141093484fcab3376c0ba7a65656c05196caaf))


### Features

* add custom CRD example ([9beb1ec](https://github.com/observeinc/manifests/commit/9beb1ec8ea25d9df3ea7d747da0bf49ffd84c8a8))
* add LICENSE ([60c35fb](https://github.com/observeinc/manifests/commit/60c35fb63f4767cb6cc684692fbf203734b718f7))



# [0.1.0](https://github.com/observeinc/manifests/compare/1e4593ae2ba4ee2db2c827efa44b7bde6433565f...v0.1.0) (2021-12-21)


### Features

* first commit ([1e4593a](https://github.com/observeinc/manifests/commit/1e4593ae2ba4ee2db2c827efa44b7bde6433565f))



