# Readme Module



### Overview

This module deploys the Kubernetes Dashboard, a web-based Kubernetes user interface, on the cluster. It sets up the dashboard using a Helm chart and configures the necessary RBAC permissions. The module also creates a service account with admin access for easy management of the cluster through the dashboard.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kubernetes_dashboard_chart_version"></a> [kubernetes\_dashboard\_chart\_version](#input\_kubernetes\_dashboard\_chart\_version) | Kubernetes Dashboard chart version | `string` | `"7.5.0"` | no |

### Outputs

No outputs.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

### Requirements

No requirements.

### Resources

| Name | Type |
|------|------|
| [helm_release.kubernetes_dashboard](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_cluster_role.superuser](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.superuser_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_service_account.all_access](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |

### Modules

No modules.
