# [0.28.0](https://github.com/observeinc/manifests/compare/v0.27.0...v0.28.0) (2023-09-13)


### Features

* upgrade grafana agent 0.36.1 ([#114](https://github.com/observeinc/manifests/issues/114)) ([1aec053](https://github.com/observeinc/manifests/commit/1aec053ffdf1b21a5635c190bb4b12c1d8c4d496))
* upgrade grafana-agent to 0.36.1 ([3512b39](https://github.com/observeinc/manifests/commit/3512b397b280570fa01410b2fb53b5487f6505ba))


### Reverts

* Revert "chore: s3 mirroring (#107)" ([78d6751](https://github.com/observeinc/manifests/commit/78d67514f9089a44e5dbb7b6686b54601d7ef077)), closes [#107](https://github.com/observeinc/manifests/issues/107)



# [0.27.0](https://github.com/observeinc/manifests/compare/v0.26.3...v0.27.0) (2023-08-22)


### Features

* **metrics:** update default cadvisor keep regex ([5602fff](https://github.com/observeinc/manifests/commit/5602fff8e3f6a8dcbcc92c9b49bde9ee6857b93e))



## [0.26.3](https://github.com/observeinc/manifests/compare/v0.26.2...v0.26.3) (2023-08-15)


### Bug Fixes

* add clusteruid to prometheus endpoint ([f25119c](https://github.com/observeinc/manifests/commit/f25119c5f30323ff9ce34b27077fd8f65e8305f6))



## [0.26.2](https://github.com/observeinc/manifests/compare/v0.26.1...v0.26.2) (2023-04-11)


### Bug Fixes

* **winlogs:** pass token in query parameter ([#106](https://github.com/observeinc/manifests/issues/106)) ([02c1ce8](https://github.com/observeinc/manifests/commit/02c1ce8cceffedc42d05c9dd7c79b4d08d707db8))
* **winlogs:** record node name in logs ([#105](https://github.com/observeinc/manifests/issues/105)) ([67a12d9](https://github.com/observeinc/manifests/commit/67a12d9ec6b6ec79e43b2106aaa6dcf2d432d843))



## [0.26.1](https://github.com/observeinc/manifests/compare/v0.26.0...v0.26.1) (2023-03-28)


### Bug Fixes

* revert otel pod_association config change ([ab24d04](https://github.com/observeinc/manifests/commit/ab24d0409f34791852deb4e61a0b3df6af5c4b11))
* uniformly apply otel-collector image version and fix pod_association config format ([#103](https://github.com/observeinc/manifests/issues/103)) ([7bfbc96](https://github.com/observeinc/manifests/commit/7bfbc969c03f84140f286f09df0b8ebbd9bae171))



