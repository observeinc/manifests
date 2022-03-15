# OpenShift example

OpenShift requires a few modifications from our base manifest:

- the creation of SecurityContextConstraints for each service account
- promoting fluent-bit container to `privileged` in order to write tail database to node `/var/log`
- increasing kube-state-events memory and CPU to deal with large number of API resources
