# 3scale SRE GitHub Workflow and Testing Infrastructure

This repository contains tools and configuration files for the testing and automation needs of the 3scale project.

[prow.mgmt.3sca.net](https://prow.mgmt.3sca.net/)

## Prow cluster access

The controller manager uses its in-cluster `prow-controller-manager` ServiceAccount
and automatically renewed projected token. Existing namespace-scoped RBAC grants
access to ProwJobs in `prow` and test Pods in `prow-test-pods`. Current jobs use the
`default` cluster; no external build-cluster kubeconfig or static API token is needed.

Removing obsolete ExternalSecret declarations does not revoke their credentials.
Argo CD does not automatically prune this application's resources: after verifying
the controller rollout and a fresh successful ProwJob, explicitly retire unused
ExternalSecrets and generated Secrets, revoke historical tokens at their issuer,
and retire their stored copies under separately approved operational scope.
