# Argo cd 

### Overview

This module deploys Argo CD, a declarative, GitOps continuous delivery tool for Kubernetes. It sets up the necessary Helm release, configures SSO integration, and exposes the Argo CD server. The module includes OAuth2 configuration for secure access.

```{tip}
  This implementation uses the official Argo CD Helm chart. You can find more details in the [Argo CD documentation](https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd).

  Helm values have been customized from the defaults, and common configuration needs are exposed as variables.

  If needed the entire helm chart can be customized by setting the `override_helm_values` variable.
```

### Compute Requirements

For optimal performance, the following resources are recommended:
- 1 CPU core
- 3GB of memory

Argo CD is relatively lightweight compared to other tools, but resource requirements may increase with the number of applications and repositories being managed.

```{warning}
  When using SSO with Google OAuth, make sure to configure the correct redirect URIs in your Google Cloud Console. The redirect URI should be `https://your-domain/api/dex/callback`.
```

### Local Deployment

Argo CD will start on port 30088 by default.

### Production Considerations

Argo CD is licensed under the Apache License 2.0, making it suitable for both personal and commercial use.

It has a built in "Dex" server for OAuth2 authentication. Google OAuth is supported out of the box via variables, other providers can be added by passing in a custom `override_helm_values` variable.

### Examples

  ```{note}
    All examples omit the configuration for the kubernetes provider and helm provider. You can find more information about how to configure these providers in the [usage](/usage) section.
  ```

#### Simple
```hcl
module "argo_cd" {
  source = "kadreio/relativistic/kubernetes//modules/argo_cd"
} 
```

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argo_cd_chart_version"></a> [argo\_cd\_chart\_version](#input\_argo\_cd\_chart\_version) | Argo CD chart version | `string` | `"7.4.3"` | no |
| <a name="input_google_oauth_client_id"></a> [google\_oauth\_client\_id](#input\_google\_oauth\_client\_id) | Google OAuth client ID | `string` | `""` | no |
| <a name="input_google_oauth_client_secret"></a> [google\_oauth\_client\_secret](#input\_google\_oauth\_client\_secret) | Google OAuth client secret | `string` | `""` | no |
| <a name="input_override_helm_values"></a> [override\_helm\_values](#input\_override\_helm\_values) | Override helm values as YAML string | `string` | `""` | no |
| <a name="input_target_domain"></a> [target\_domain](#input\_target\_domain) | The url of the deployed application | `string` | `"localhost:30088"` | no |

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
| [helm_release.argo_cd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_service.expose_argo_cd_webserver](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |

### Modules

No modules.
