# Lightdash 

### Overview

This module deploys Lightdash, an open-source business intelligence tool, on Kubernetes. It sets up the Lightdash server and configures the necessary database connections using a Helm chart. The module also enables persistent storage and configures the service for accessing the Lightdash UI.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lightdash_chart_version"></a> [lightdash\_chart\_version](#input\_lightdash\_chart\_version) | Lightdash chart version | `string` | `"0.8.9"` | no |
| <a name="input_override_helm_values"></a> [override\_helm\_values](#input\_override\_helm\_values) | List of Helm values files to override default configurations for Lightdash | `list(string)` | `[]` | no |

### Outputs

No outputs.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

### Requirements

No requirements.

### Resources

| Name | Type |
|------|------|
| [helm_release.lightdash](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

### Modules

No modules.
