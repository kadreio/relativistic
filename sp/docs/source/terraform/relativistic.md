# Relativistic Module



### Overview

# Relativistic

Relativistic is a Terraform, Helm, and custom configuration project to be able to deploy an production grade open source data stack quickly.

For full documentation, visit [docs.relativistic.io](https://docs.relativistic.io).

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_airbyte_chart_version"></a> [airbyte\_chart\_version](#input\_airbyte\_chart\_version) | Airbyte chart version | `string` | `"1.1.0"` | no |
| <a name="input_airbyte_enable_proxy"></a> [airbyte\_enable\_proxy](#input\_airbyte\_enable\_proxy) | Enable OAuth2 Proxy | `bool` | `true` | no |
| <a name="input_airbyte_enabled"></a> [airbyte\_enabled](#input\_airbyte\_enabled) | Enable Airbyte deployment | `bool` | `false` | no |
| <a name="input_airbyte_override_helm_values"></a> [airbyte\_override\_helm\_values](#input\_airbyte\_override\_helm\_values) | Override helm values for Airbyte as YAML string | `string` | `""` | no |
| <a name="input_airbyte_postgres_host"></a> [airbyte\_postgres\_host](#input\_airbyte\_postgres\_host) | Airbyte PostgreSQL host | `string` | `"airbyte"` | no |
| <a name="input_airbyte_postgres_name"></a> [airbyte\_postgres\_name](#input\_airbyte\_postgres\_name) | Airbyte PostgreSQL database name | `string` | `"airbyte"` | no |
| <a name="input_airbyte_postgres_password"></a> [airbyte\_postgres\_password](#input\_airbyte\_postgres\_password) | Airbyte PostgreSQL password | `string` | `"airbyte"` | no |
| <a name="input_airbyte_postgres_port"></a> [airbyte\_postgres\_port](#input\_airbyte\_postgres\_port) | Airbyte PostgreSQL port | `number` | `5432` | no |
| <a name="input_airbyte_postgres_user"></a> [airbyte\_postgres\_user](#input\_airbyte\_postgres\_user) | Airbyte PostgreSQL user | `string` | `"airbyte"` | no |
| <a name="input_airbyte_subdomain"></a> [airbyte\_subdomain](#input\_airbyte\_subdomain) | Subdomain for Airbyte | `string` | `"airbyte"` | no |
| <a name="input_airbyte_use_external_pg"></a> [airbyte\_use\_external\_pg](#input\_airbyte\_use\_external\_pg) | Use external PostgreSQL for Airbyte | `bool` | `false` | no |
| <a name="input_airbyte_userlist"></a> [airbyte\_userlist](#input\_airbyte\_userlist) | User list for Airbyte | `string` | `""` | no |
| <a name="input_airflow_chart_version"></a> [airflow\_chart\_version](#input\_airflow\_chart\_version) | Airflow chart version | `string` | `"8.8.0"` | no |
| <a name="input_airflow_enabled"></a> [airflow\_enabled](#input\_airflow\_enabled) | Enable Apache Airflow deployment | `bool` | `false` | no |
| <a name="input_airflow_override_helm_values"></a> [airflow\_override\_helm\_values](#input\_airflow\_override\_helm\_values) | List of Helm values files to override default configurations for Airflow | `list(string)` | `[]` | no |
| <a name="input_analytics_postgres_enabled"></a> [analytics\_postgres\_enabled](#input\_analytics\_postgres\_enabled) | Enable Analytics PostgreSQL deployment | `bool` | `false` | no |
| <a name="input_argo_cd_chart_version"></a> [argo\_cd\_chart\_version](#input\_argo\_cd\_chart\_version) | Argo CD chart version | `string` | `"7.4.3"` | no |
| <a name="input_argo_cd_enabled"></a> [argo\_cd\_enabled](#input\_argo\_cd\_enabled) | Enable Argo CD deployment | `bool` | `false` | no |
| <a name="input_argo_cd_override_helm_values"></a> [argo\_cd\_override\_helm\_values](#input\_argo\_cd\_override\_helm\_values) | Override helm values for Argo CD as YAML string | `string` | `""` | no |
| <a name="input_argo_cd_subdomain"></a> [argo\_cd\_subdomain](#input\_argo\_cd\_subdomain) | Subdomain for Argo CD | `string` | `"argocd"` | no |
| <a name="input_argo_workflows_chart_version"></a> [argo\_workflows\_chart\_version](#input\_argo\_workflows\_chart\_version) | Argo Workflows chart version | `string` | `"0.42.3"` | no |
| <a name="input_argo_workflows_enabled"></a> [argo\_workflows\_enabled](#input\_argo\_workflows\_enabled) | Enable Argo Workflows deployment | `bool` | `false` | no |
| <a name="input_argo_workflows_override_helm_values"></a> [argo\_workflows\_override\_helm\_values](#input\_argo\_workflows\_override\_helm\_values) | Override helm values for Argo Workflows as YAML string | `string` | `""` | no |
| <a name="input_argo_workflows_rbac_rule"></a> [argo\_workflows\_rbac\_rule](#input\_argo\_workflows\_rbac\_rule) | RBAC rule for Argo Workflows | `string` | `"false"` | no |
| <a name="input_argo_workflows_subdomain"></a> [argo\_workflows\_subdomain](#input\_argo\_workflows\_subdomain) | Subdomain for Argo Workflows | `string` | `"argo-workflows"` | no |
| <a name="input_clickhouse_chart_version"></a> [clickhouse\_chart\_version](#input\_clickhouse\_chart\_version) | Clickhouse chart version | `string` | `"0.24.0"` | no |
| <a name="input_clickhouse_enabled"></a> [clickhouse\_enabled](#input\_clickhouse\_enabled) | Enable Clickhouse deployment | `bool` | `false` | no |
| <a name="input_clickhouse_override_helm_values"></a> [clickhouse\_override\_helm\_values](#input\_clickhouse\_override\_helm\_values) | Override helm values for Clickhouse as YAML string | `string` | `""` | no |
| <a name="input_configuration_postgres_enabled"></a> [configuration\_postgres\_enabled](#input\_configuration\_postgres\_enabled) | Enable Configuration PostgreSQL deployment | `bool` | `false` | no |
| <a name="input_dagster_chart_version"></a> [dagster\_chart\_version](#input\_dagster\_chart\_version) | Dagster chart version | `string` | `"1.7.1"` | no |
| <a name="input_dagster_enabled"></a> [dagster\_enabled](#input\_dagster\_enabled) | Enable Dagster deployment | `bool` | `false` | no |
| <a name="input_dagster_override_helm_values"></a> [dagster\_override\_helm\_values](#input\_dagster\_override\_helm\_values) | Override helm values for Dagster as YAML string | `string` | `""` | no |
| <a name="input_domain_config_deployment_domain"></a> [domain\_config\_deployment\_domain](#input\_domain\_config\_deployment\_domain) | Deployment domain for configurations | `string` | `""` | no |
| <a name="input_domain_config_zone_domain"></a> [domain\_config\_zone\_domain](#input\_domain\_config\_zone\_domain) | Zone domain for configurations | `string` | `""` | no |
| <a name="input_google_oauth_client_id"></a> [google\_oauth\_client\_id](#input\_google\_oauth\_client\_id) | Google OAuth client ID | `string` | `""` | no |
| <a name="input_google_oauth_client_secret"></a> [google\_oauth\_client\_secret](#input\_google\_oauth\_client\_secret) | Google OAuth client secret | `string` | `""` | no |
| <a name="input_kestra_enabled"></a> [kestra\_enabled](#input\_kestra\_enabled) | Enable Kestra deployment | `bool` | `false` | no |
| <a name="input_kubernetes_config_path"></a> [kubernetes\_config\_path](#input\_kubernetes\_config\_path) | Path to Kubernetes configuration file | `string` | `"~/.kube/config"` | no |
| <a name="input_kubernetes_dashboard_chart_version"></a> [kubernetes\_dashboard\_chart\_version](#input\_kubernetes\_dashboard\_chart\_version) | Kubernetes Dashboard chart version | `string` | `"7.5.0"` | no |
| <a name="input_kubernetes_dashboard_enabled"></a> [kubernetes\_dashboard\_enabled](#input\_kubernetes\_dashboard\_enabled) | Enable Kubernetes Dashboard deployment | `bool` | `false` | no |
| <a name="input_lightdash_chart_version"></a> [lightdash\_chart\_version](#input\_lightdash\_chart\_version) | Lightdash chart version | `string` | `"0.8.9"` | no |
| <a name="input_lightdash_enabled"></a> [lightdash\_enabled](#input\_lightdash\_enabled) | Enable Lightdash deployment | `bool` | `false` | no |
| <a name="input_lightdash_override_helm_values"></a> [lightdash\_override\_helm\_values](#input\_lightdash\_override\_helm\_values) | List of Helm values files to override default configurations for Lightdash | `list(string)` | `[]` | no |
| <a name="input_loki_chart_version"></a> [loki\_chart\_version](#input\_loki\_chart\_version) | Loki chart version | `string` | `"2.10.0"` | no |
| <a name="input_loki_override_helm_values"></a> [loki\_override\_helm\_values](#input\_loki\_override\_helm\_values) | List of Helm values files to override default configurations for Loki | `list(string)` | `[]` | no |
| <a name="input_prometheus_enabled"></a> [prometheus\_enabled](#input\_prometheus\_enabled) | Enable Prometheus deployment | `bool` | `false` | no |
| <a name="input_prometheus_operator_chart_version"></a> [prometheus\_operator\_chart\_version](#input\_prometheus\_operator\_chart\_version) | Prometheus Operator chart version | `string` | `"61.9.0"` | no |
| <a name="input_prometheus_override_helm_values"></a> [prometheus\_override\_helm\_values](#input\_prometheus\_override\_helm\_values) | List of Helm values files to override default configurations for Prometheus | `list(string)` | `[]` | no |
| <a name="input_superset_chart_version"></a> [superset\_chart\_version](#input\_superset\_chart\_version) | Superset chart version | `string` | `"0.12.9"` | no |
| <a name="input_superset_default_password"></a> [superset\_default\_password](#input\_superset\_default\_password) | Default password for Apache Superset | `string` | `"admin"` | no |
| <a name="input_superset_default_user"></a> [superset\_default\_user](#input\_superset\_default\_user) | Default user for Apache Superset | `string` | `"admin@superset.com"` | no |
| <a name="input_superset_enabled"></a> [superset\_enabled](#input\_superset\_enabled) | Enable Apache Superset deployment | `bool` | `false` | no |
| <a name="input_superset_local_exposed_port"></a> [superset\_local\_exposed\_port](#input\_superset\_local\_exposed\_port) | Local exposed port for Apache Superset | `number` | `30086` | no |
| <a name="input_superset_override_helm_values"></a> [superset\_override\_helm\_values](#input\_superset\_override\_helm\_values) | List of Helm values files to override default configurations for Superset | `list(string)` | `[]` | no |
| <a name="input_superset_secret_key"></a> [superset\_secret\_key](#input\_superset\_secret\_key) | Secret key for Apache Superset | `string` | `"CHANGE_ME"` | no |
| <a name="input_tooljet_enabled"></a> [tooljet\_enabled](#input\_tooljet\_enabled) | Enable Tooljet deployment | `bool` | `false` | no |
| <a name="input_ubuntu_enabled"></a> [ubuntu\_enabled](#input\_ubuntu\_enabled) | Enable Ubuntu deployment | `bool` | `false` | no |
| <a name="input_windmill_chart_version"></a> [windmill\_chart\_version](#input\_windmill\_chart\_version) | Windmill chart version | `string` | `"2.0.214"` | no |
| <a name="input_windmill_enabled"></a> [windmill\_enabled](#input\_windmill\_enabled) | Enable Windmill deployment | `bool` | `false` | no |
| <a name="input_windmill_override_helm_values"></a> [windmill\_override\_helm\_values](#input\_windmill\_override\_helm\_values) | List of Helm values files to override default configurations for Windmill | `list(string)` | `[]` | no |

### Outputs

No outputs.

### Providers

No providers.

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.21.0 |

### Resources

No resources.

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_airbyte"></a> [airbyte](#module\_airbyte) | ./modules/airbyte | n/a |
| <a name="module_airflow"></a> [airflow](#module\_airflow) | ./modules/airflow | n/a |
| <a name="module_analytics_postgres"></a> [analytics\_postgres](#module\_analytics\_postgres) | ./modules/analytics_postgres | n/a |
| <a name="module_argo_cd"></a> [argo\_cd](#module\_argo\_cd) | ./modules/argo_cd | n/a |
| <a name="module_argo_workflows"></a> [argo\_workflows](#module\_argo\_workflows) | ./modules/argo_workflows | n/a |
| <a name="module_clickhouse"></a> [clickhouse](#module\_clickhouse) | ./modules/clickhouse | n/a |
| <a name="module_configuration_postgres"></a> [configuration\_postgres](#module\_configuration\_postgres) | ./modules/configuration_postgres | n/a |
| <a name="module_dagster"></a> [dagster](#module\_dagster) | ./modules/dagster | n/a |
| <a name="module_kubernetes_dashboard"></a> [kubernetes\_dashboard](#module\_kubernetes\_dashboard) | ./modules/kubernetes-dashboard | n/a |
| <a name="module_lightdash"></a> [lightdash](#module\_lightdash) | ./modules/lightdash | n/a |
| <a name="module_prometheus"></a> [prometheus](#module\_prometheus) | ./modules/prometheus | n/a |
| <a name="module_superset"></a> [superset](#module\_superset) | ./modules/superset | n/a |
| <a name="module_ubuntu"></a> [ubuntu](#module\_ubuntu) | ./modules/ubuntu | n/a |
| <a name="module_windmill"></a> [windmill](#module\_windmill) | ./modules/windmill | n/a |
