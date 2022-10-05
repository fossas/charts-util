# manifest-shim
A shim for installing arbitrary resources with helm.

This chart deploys arbitrary objects, service accounts, and cluster issuers into Kubernetes.

When using automation such as flux v2, this shim can be used to wrap stray manifests as HelmReleases.
