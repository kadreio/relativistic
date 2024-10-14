# Windmill Module

### Requirements

No requirements.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [helm_release.windmill](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_service.expose_windmill_webserver](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_windmill_chart_version"></a> [windmill\_chart\_version](#input\_windmill\_chart\_version) | Windmill chart version | `string` | `"2.0.214"` | no |

### Outputs

No outputs.
