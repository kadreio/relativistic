# Airbyte 


{bdg-warning}`Beta`

### Overview

This module deploys Airbyte, an open-source data integration platform, on Kubernetes. It sets up the necessary Helm release, configures the database, and exposes the Airbyte webserver. This module also includes OAuth2 proxy configuration for secure access.

```{tip}
  This implementation uses the official Airbyte Helm chart. You can find more details in the [Airbyte documentation](https://docs.airbyte.com/deploying-airbyte/on-kubernetes/deploy-airbyte-on-kubernetes). 

  Helm values have been customized from the defaults, and common configuration needs are exposed as variables.

  If needed the entire helm chart can be customized by setting the `helm_values` variable.
```

### Compute Nodes

For optimal performance, the following resources are recommended:
- 4 or more CPU cores
- At least 8GB of memory

While Airbyte can run in low-resource mode with 2 CPUs and 4GB RAM, this is not recommended for production deployments.

Note that Airbyte will schedule new pods for every sync job.

```{note}
  Airbyte includes a self hosted version of Postgres. This will not back iteslf up, and is not HA. For many use cases, this is not a problem, as Airbyte is not a system of record itself, and can easily be recreated in disaster recovery. However, if you care about configuration durability, you should consider using a managed database. The module exposes postgres configuration options, see the example for more details.
```

```{Warning}
  Some versions of Airbyte have issues with tolerances and taints. See [this discussion](https://discuss.airbyte.io/t/toleration-changes-in-airbyte-helm-deployment/7524) for more details.
```

```{warning}
  Airbytes included version of Minio has issues starting on ARM64 nodes. Use AMD64 nodes instead.
```

```{Warning}
  If deploying on EKS, note that Fargate will not work, as airbyte pods dynamically create new pods, which will not work on Fargate. See [this discussion](https://docs.airbyte.com/enterprise-setup/implementation-guide) for more details.
```

### Local Deployment

Airbyte will start on port 30080 by default.

### Production Considerations

Airbyte is licensed under the Elastic License 2.0. Consult the [Airbyte licensing page](https://github.com/airbytehq/airbyte/blob/master/LICENSE) for more details for how that will impact your usecase.

Airbyte OSS does not include authentication or authorization. We recommend using oauth2 proxy to secure access to the Airbyte webserver. For more advanced security, consider using an enterprise version of Airbyte.

To use the oauth2 proxy, you will need to provide a client id and secret. You can get these by creating a project in the [Google Developer Console](https://console.cloud.google.com/apis/credentials). Also, provide a list of emails to allow access to the service via the `userlist` variable. See the variable se


### Examples

  ```{note}
    All examples omit the configuration for the kubernetes provider and helm provider. You can find more information about how to configure these providers in the [usage](/usage) section.
  ```

#### Simple
```hcl
module "airbyte" {
    source = "kadreio/relativistic/kubernetes//modules/airbyte"

    use_external_pg = false
    enable_proxy = false
}
```

#### OAuth2 Proxy and External Database
```hcl
module "airbyte" {
  source = "kadreio/relativistic/kubernetes//modules/airbyte"

  # Enable and configure OAuth2 proxy
  enable_proxy = true
  google_oauth_client_id     = "your-client-id"
  google_oauth_client_secret = "your-client-secret"
  # cookie_secret will be auto-generated if not provided
  
  # Configure allowed users
  userlist = <<EOF
    user1@yourdomain.com
    user2@yourdomain.com
  EOF

  # Replace with your external PostgreSQL configuration
  use_external_pg = true
  db_host     = "your-postgres-host"
  db_port     = 5432
  db_name     = "airbyte"
  db_user     = "airbyte_user"
  db_password = "your-secure-password"

  # Optional: Configure custom domain
  target_domain     = "airbyte.yourdomain.com"
  deployment_domain = "yourdomain.com"
  airbyte_subdomain = "airbyte"
} 
```

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
