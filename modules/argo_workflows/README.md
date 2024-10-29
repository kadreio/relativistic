# Argo workflows 

{bdg-success}`Released`

### Overview

This module deploys Argo Workflows, an open-source container-native workflow engine for orchestrating parallel jobs on Kubernetes. It sets up the Argo Workflows controller and server using a Helm chart, configures RBAC, and enables SSO integration for secure access to the Argo Workflows UI.

```{tip}
  This implementation uses the official Argo Workflows Helm chart. You can find more details in the [Argo Workflows documentation](https://github.com/argoproj/argo-helm/tree/main/charts/argo-workflows).

  Helm values have been customized from the defaults, and common configuration needs are exposed as variables.

  If needed the entire helm chart can be customized by setting the `override_helm_values` variable.

  Additionally, there is a large amount of security roles configuration.
```

### Compute Requirements

For optimal performance, the following resources are recommended:
- 1 CPU core
- 2GB of memory

Resource requirements will scale with the number and complexity of workflows being executed.

```{warning}
  When using SSO with Google OAuth, make sure to configure the correct redirect URIs in your Google Cloud Console. The redirect URI should be `https://your-domain/oauth2/callback`.
```

### Local Deployment

Argo Workflows will start on port 30083 by default.

### Production Considerations

Argo Workflows is licensed under the Apache License 2.0, making it suitable for both personal and commercial use.

### Examples

  ```{note}
    All examples omit the configuration for the kubernetes provider and helm provider. You can find more information about how to configure these providers in the [usage](/usage) section.
  ```

#### Simple
```hcl
module "argo_workflows" {
  source = "kadreio/relativistic/kubernetes//modules/argo_workflows"
} 
```

#### With SSO
```hcl
module "argo_workflows" {
  source = "kadreio/relativistic/kubernetes//modules/argo_workflows"

  # Enable SSO authentication
  auth_mode = "sso"
  
  # Configure Google OAuth
  google_oauth_client_id     = "your-client-id"
  google_oauth_client_secret = "your-client-secret"
  
  # Configure domain for SSO
  target_domain = "argo-workflows.yourdomain.com"

  # Configure allowed domains for SSO
  allowed_domains = ["yourdomain.com"]

  # Optional: Configure RBAC rule for admin access
  rbac_rule = "email == 'admin@yourdomain.com' or email == 'admin2@example.com'"
} 
```

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
