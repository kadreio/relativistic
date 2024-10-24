# Airbyte Module



### Overview

This module deploys Airbyte, an open-source data integration platform, on Kubernetes. It sets up the necessary Helm release, configures the database, and exposes the Airbyte webserver. This module also includes OAuth2 proxy configuration for secure access.

### Required Compute

### Production Considerations



### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_airbyte_chart_version"></a> [airbyte\_chart\_version](#input\_airbyte\_chart\_version) | Airbyte chart version | `string` | `"1.1.0"` | no |
| <a name="input_airbyte_subdomain"></a> [airbyte\_subdomain](#input\_airbyte\_subdomain) | The subdomain for Airbyte | `string` | `"airbyte"` | no |
| <a name="input_cookie_secret"></a> [cookie\_secret](#input\_cookie\_secret) | Random value to use as a cookie secret for OAuth2 Proxy | `string` | `""` | no |
| <a name="input_db_host"></a> [db\_host](#input\_db\_host) | PostgreSQL database host | `string` | `"airbyte-postgresql"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | PostgreSQL database name | `string` | `"airbyte"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | PostgreSQL database password | `string` | `""` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | PostgreSQL database port | `number` | `5432` | no |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | PostgreSQL database user | `string` | `"airbyte"` | no |
| <a name="input_deployment_domain"></a> [deployment\_domain](#input\_deployment\_domain) | The deployment domain | `string` | `""` | no |
| <a name="input_enable_proxy"></a> [enable\_proxy](#input\_enable\_proxy) | Enable OAuth2 proxy for Airbyte | `bool` | `true` | no |
| <a name="input_google_oauth_client_id"></a> [google\_oauth\_client\_id](#input\_google\_oauth\_client\_id) | Google OAuth client ID | `string` | `""` | no |
| <a name="input_google_oauth_client_secret"></a> [google\_oauth\_client\_secret](#input\_google\_oauth\_client\_secret) | Google OAuth client secret | `string` | `""` | no |
| <a name="input_override_helm_values"></a> [override\_helm\_values](#input\_override\_helm\_values) | Override helm values as YAML string | `string` | `""` | no |
| <a name="input_target_domain"></a> [target\_domain](#input\_target\_domain) | The url of the deployed application | `string` | `"localhost:30080"` | no |
| <a name="input_use_external_pg"></a> [use\_external\_pg](#input\_use\_external\_pg) | Use external PostgreSQL for Airbyte | `bool` | `false` | no |
| <a name="input_userlist"></a> [userlist](#input\_userlist) | Newline delimeted list of users that can access the service | `string` | `"        fake@example.com\n        fake2@example.com\n"` | no |

### Outputs

No outputs.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.16.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.33.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

### Requirements

No requirements.

### Resources

| Name | Type |
|------|------|
| [helm_release.airbyte](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.oauth2_proxy](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_secret.db_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service.expose_airbyte_webserver](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service.expose_proxy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [random_string.cookie_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

### Modules

No modules.
