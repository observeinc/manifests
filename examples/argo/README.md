# Observe Argo

This directory contains an example kustomization which collects Argo CRD data.
We use our base events component and configure a ClusterRole to allow read
access to all resources within `argoproj.io`.

We assume our stack has already been installed, and therefore both the
`observe` namespace and `credentials` configmap are in place. To install, run:

```
kubectl apply -k github.com/observeinc/manifests/examples/argo
```


