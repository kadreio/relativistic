# Readme Module



### Overview

This module deploys Argo Workflows, an open-source container-native workflow engine for orchestrating parallel jobs on Kubernetes. It sets up the Argo Workflows controller and server using a Helm chart, configures RBAC, and enables SSO integration for secure access to the Argo Workflows UI.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_domains"></a> [allowed\_domains](#input\_allowed\_domains) | The domains that are allowed to access Argo Workflows | `list(string)` | `[]` | no |
| <a name="input_argo_workflows_chart_version"></a> [argo\_workflows\_chart\_version](#input\_argo\_workflows\_chart\_version) | Argo Workflows chart version | `string` | `"0.42.3"` | no |
| <a name="input_argo_workflows_subdomain"></a> [argo\_workflows\_subdomain](#input\_argo\_workflows\_subdomain) | The subdomain for Argo Workflows | `string` | `"argo-workflows"` | no |
| <a name="input_auth_mode"></a> [auth\_mode](#input\_auth\_mode) | The authentication mode for Argo Workflows. Options: server, sso, client | `string` | `"server"` | no |
| <a name="input_google_oauth_client_id"></a> [google\_oauth\_client\_id](#input\_google\_oauth\_client\_id) | Google OAuth client ID | `string` | `""` | no |
| <a name="input_google_oauth_client_secret"></a> [google\_oauth\_client\_secret](#input\_google\_oauth\_client\_secret) | Google OAuth client secret | `string` | `""` | no |
| <a name="input_override_helm_values"></a> [override\_helm\_values](#input\_override\_helm\_values) | Override helm values as YAML string | `string` | `""` | no |
| <a name="input_rbac_rule"></a> [rbac\_rule](#input\_rbac\_rule) | Rule to validate if a user should be logged in as admin. | `string` | `"false"` | no |
| <a name="input_target_domain"></a> [target\_domain](#input\_target\_domain) | The url of the deployed application | `string` | `"localhost:30083"` | no |

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
| [helm_release.argo_workflows](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_cluster_role.argo_server_cluster_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.super_admin](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.argo_server_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.super_admin_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_secret.admin-argo-service-account-token](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.argo_sso](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.other-argo-service-account-token](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service.expose_argo_workflows_webserver](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service_account.admin_argo](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [kubernetes_service_account.argo_server](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [kubernetes_service_account.other_argo](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |

### Modules

No modules.
