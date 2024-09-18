## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.21.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_airbyte"></a> [airbyte](#module\_airbyte) | ./modules/airbyte | n/a |
| <a name="module_airflow"></a> [airflow](#module\_airflow) | ./modules/airflow | n/a |
| <a name="module_analytics_postgres"></a> [analytics\_postgres](#module\_analytics\_postgres) | ./modules/analytics_postgres | n/a |
| <a name="module_argo_cd"></a> [argo\_cd](#module\_argo\_cd) | ./modules/argo_cd | n/a |
| <a name="module_argo_workflows"></a> [argo\_workflows](#module\_argo\_workflows) | ./modules/argo_workflows | n/a |
| <a name="module_configuration_postgres"></a> [configuration\_postgres](#module\_configuration\_postgres) | ./modules/configuration_postgres | n/a |
| <a name="module_dagster"></a> [dagster](#module\_dagster) | ./modules/dagster | n/a |
| <a name="module_kubernetes_dashboard"></a> [kubernetes\_dashboard](#module\_kubernetes\_dashboard) | ./modules/kubernetes-dashboard | n/a |
| <a name="module_lightdash"></a> [lightdash](#module\_lightdash) | ./modules/lightdash | n/a |
| <a name="module_prometheus"></a> [prometheus](#module\_prometheus) | ./modules/prometheus | n/a |
| <a name="module_superset"></a> [superset](#module\_superset) | ./modules/superset | n/a |
| <a name="module_windmill"></a> [windmill](#module\_windmill) | ./modules/windmill | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_airbyte_enabled"></a> [airbyte\_enabled](#input\_airbyte\_enabled) | Enable Airbyte deployment | `bool` | `false` | no |
| <a name="input_airbyte_postgres_host"></a> [airbyte\_postgres\_host](#input\_airbyte\_postgres\_host) | Airbyte PostgreSQL host | `string` | `"airbyte"` | no |
| <a name="input_airbyte_postgres_name"></a> [airbyte\_postgres\_name](#input\_airbyte\_postgres\_name) | Airbyte PostgreSQL database name | `string` | `"airbyte"` | no |
| <a name="input_airbyte_postgres_password"></a> [airbyte\_postgres\_password](#input\_airbyte\_postgres\_password) | Airbyte PostgreSQL password | `string` | `"airbyte"` | no |
| <a name="input_airbyte_postgres_port"></a> [airbyte\_postgres\_port](#input\_airbyte\_postgres\_port) | Airbyte PostgreSQL port | `number` | `5432` | no |
| <a name="input_airbyte_postgres_user"></a> [airbyte\_postgres\_user](#input\_airbyte\_postgres\_user) | Airbyte PostgreSQL user | `string` | `"airbyte"` | no |
| <a name="input_airbyte_subdomain"></a> [airbyte\_subdomain](#input\_airbyte\_subdomain) | Subdomain for Airbyte | `string` | `"airbyte"` | no |
| <a name="input_airbyte_use_external_pg"></a> [airbyte\_use\_external\_pg](#input\_airbyte\_use\_external\_pg) | Use external PostgreSQL for Airbyte | `bool` | `false` | no |
| <a name="input_airbyte_userlist"></a> [airbyte\_userlist](#input\_airbyte\_userlist) | User list for Airbyte | `string` | `""` | no |
| <a name="input_airflow_enabled"></a> [airflow\_enabled](#input\_airflow\_enabled) | Enable Apache Airflow deployment | `bool` | `false` | no |
| <a name="input_analytics_postgres_enabled"></a> [analytics\_postgres\_enabled](#input\_analytics\_postgres\_enabled) | Enable Analytics PostgreSQL deployment | `bool` | `false` | no |
| <a name="input_argo_cd_enabled"></a> [argo\_cd\_enabled](#input\_argo\_cd\_enabled) | Enable Argo CD deployment | `bool` | `false` | no |
| <a name="input_argo_cd_subdomain"></a> [argo\_cd\_subdomain](#input\_argo\_cd\_subdomain) | Subdomain for Argo CD | `string` | `"argocd"` | no |
| <a name="input_argo_workflows_enabled"></a> [argo\_workflows\_enabled](#input\_argo\_workflows\_enabled) | Enable Argo Workflows deployment | `bool` | `false` | no |
| <a name="input_argo_workflows_rbac_rule"></a> [argo\_workflows\_rbac\_rule](#input\_argo\_workflows\_rbac\_rule) | RBAC rule for Argo Workflows | `string` | `"false"` | no |
| <a name="input_argo_workflows_subdomain"></a> [argo\_workflows\_subdomain](#input\_argo\_workflows\_subdomain) | Subdomain for Argo Workflows | `string` | `"argo-workflows"` | no |
| <a name="input_dagster_enabled"></a> [dagster\_enabled](#input\_dagster\_enabled) | Enable Dagster deployment | `bool` | `false` | no |
| <a name="input_domain_config_deployment_domain"></a> [domain\_config\_deployment\_domain](#input\_domain\_config\_deployment\_domain) | Deployment domain for configurations | `string` | `""` | no |
| <a name="input_domain_config_zone_domain"></a> [domain\_config\_zone\_domain](#input\_domain\_config\_zone\_domain) | Zone domain for configurations | `string` | `""` | no |
| <a name="input_google_oauth_client_id"></a> [google\_oauth\_client\_id](#input\_google\_oauth\_client\_id) | Google OAuth client ID | `string` | `""` | no |
| <a name="input_google_oauth_client_secret"></a> [google\_oauth\_client\_secret](#input\_google\_oauth\_client\_secret) | Google OAuth client secret | `string` | `""` | no |
| <a name="input_kestra_enabled"></a> [kestra\_enabled](#input\_kestra\_enabled) | Enable Kestra deployment | `bool` | `false` | no |
| <a name="input_kubernetes_config_path"></a> [kubernetes\_config\_path](#input\_kubernetes\_config\_path) | Path to Kubernetes configuration file | `string` | `"~/.kube/config"` | no |
| <a name="input_kubernetes_dashboard_enabled"></a> [kubernetes\_dashboard\_enabled](#input\_kubernetes\_dashboard\_enabled) | Enable Kubernetes Dashboard deployment | `bool` | `false` | no |
| <a name="input_lightdash_enabled"></a> [lightdash\_enabled](#input\_lightdash\_enabled) | Enable Lightdash deployment | `bool` | `false` | no |
| <a name="input_prometheus_enabled"></a> [prometheus\_enabled](#input\_prometheus\_enabled) | Enable Prometheus deployment | `bool` | `false` | no |
| <a name="input_superset_default_password"></a> [superset\_default\_password](#input\_superset\_default\_password) | Default password for Apache Superset | `string` | `"admin"` | no |
| <a name="input_superset_default_user"></a> [superset\_default\_user](#input\_superset\_default\_user) | Default user for Apache Superset | `string` | `"admin@superset.com"` | no |
| <a name="input_superset_enabled"></a> [superset\_enabled](#input\_superset\_enabled) | Enable Apache Superset deployment | `bool` | `false` | no |
| <a name="input_superset_local_exposed_port"></a> [superset\_local\_exposed\_port](#input\_superset\_local\_exposed\_port) | Local exposed port for Apache Superset | `number` | `30086` | no |
| <a name="input_superset_secret_key"></a> [superset\_secret\_key](#input\_superset\_secret\_key) | Secret key for Apache Superset | `string` | `"YOUR_OWN_RANDOM_GENERATED_SECRET_KEY"` | no |
| <a name="input_tooljet_enabled"></a> [tooljet\_enabled](#input\_tooljet\_enabled) | Enable Tooljet deployment | `bool` | `false` | no |
| <a name="input_windmill_enabled"></a> [windmill\_enabled](#input\_windmill\_enabled) | Enable Windmill deployment | `bool` | `false` | no |

## Outputs

No outputs.
