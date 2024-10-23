# Readme Module



### Overview

This module deploys Windmill, an open-source developer platform for creating, sharing, and running scripts and workflows, on Kubernetes. It sets up the Windmill server and its required components using a Helm chart. The module configures the necessary resources for running scripts and workflows, and exposes the Windmill UI for easy management and execution of tasks.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_override_helm_values"></a> [override\_helm\_values](#input\_override\_helm\_values) | List of Helm values files to override default configurations for Windmill | `list(string)` | `[]` | no |
| <a name="input_windmill_chart_version"></a> [windmill\_chart\_version](#input\_windmill\_chart\_version) | Windmill chart version | `string` | `"2.0.214"` | no |

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
| [helm_release.windmill](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_service.expose_windmill_webserver](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |

### Modules

No modules.
