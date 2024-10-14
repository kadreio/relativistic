# Configuration postgres Module

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
| [helm_release.configuration_postgres](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_secret.configuration_postgres](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |
| [kubernetes_service.configuration_postgres](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_configuration_postgres_chart_version"></a> [configuration\_postgres\_chart\_version](#input\_configuration\_postgres\_chart\_version) | Configuration Postgres chart version | `string` | `"15.2.5"` | no |
| <a name="input_configuration_postgres_default_user"></a> [configuration\_postgres\_default\_user](#input\_configuration\_postgres\_default\_user) | Default user for postgres | `string` | `"postgres"` | no |
| <a name="input_postgres_default_password"></a> [postgres\_default\_password](#input\_postgres\_default\_password) | Default user for postgres | `string` | `"postgres"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_postgres_host"></a> [postgres\_host](#output\_postgres\_host) | n/a |
| <a name="output_postgres_password"></a> [postgres\_password](#output\_postgres\_password) | n/a |
| <a name="output_postgres_service_database"></a> [postgres\_service\_database](#output\_postgres\_service\_database) | n/a |
| <a name="output_postgres_service_port"></a> [postgres\_service\_port](#output\_postgres\_service\_port) | n/a |
| <a name="output_postgres_username"></a> [postgres\_username](#output\_postgres\_username) | n/a |
