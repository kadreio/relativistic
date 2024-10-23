variable "airbyte_enabled" {
  description = "Enable Airbyte deployment"
  type        = bool
  default     = false
}

variable "airbyte_postgres_host" {
  description = "Airbyte PostgreSQL host"
  type        = string
  default     = "airbyte"
}

variable "airbyte_postgres_port" {
  description = "Airbyte PostgreSQL port"
  type        = number
  default     = 5432
}

variable "airbyte_postgres_name" {
  description = "Airbyte PostgreSQL database name"
  type        = string
  default     = "airbyte"
}

variable "airbyte_postgres_user" {
  description = "Airbyte PostgreSQL user"
  type        = string
  default     = "airbyte"
}

variable "airbyte_postgres_password" {
  description = "Airbyte PostgreSQL password"
  type        = string
  default     = "airbyte"
  sensitive   = true
}

variable "airbyte_subdomain" {
  description = "Subdomain for Airbyte"
  type        = string
  default     = "airbyte"
}

variable "airbyte_userlist" {
  description = "User list for Airbyte"
  type        = string
  default     = ""
}

variable "airbyte_use_external_pg" {
  description = "Use external PostgreSQL for Airbyte"
  type        = bool
  default     = false
}

variable "superset_enabled" {
  description = "Enable Apache Superset deployment"
  type        = bool
  default     = false
}

variable "superset_default_user" {
  description = "Default user for Apache Superset"
  type        = string
  default     = "admin@superset.com"
}

variable "superset_default_password" {
  description = "Default password for Apache Superset"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "superset_secret_key" {
  description = "Secret key for Apache Superset"
  type        = string
  default     = "CHANGE_ME"
  sensitive   = true
}

variable "superset_local_exposed_port" {
  description = "Local exposed port for Apache Superset"
  type        = number
  default     = 30086
}

variable "airflow_enabled" {
  description = "Enable Apache Airflow deployment"
  type        = bool
  default     = false
}

variable "analytics_postgres_enabled" {
  description = "Enable Analytics PostgreSQL deployment"
  type        = bool
  default     = false
}

variable "dagster_enabled" {
  description = "Enable Dagster deployment"
  type        = bool
  default     = false
}

variable "lightdash_enabled" {
  description = "Enable Lightdash deployment"
  type        = bool
  default     = false
}

variable "tooljet_enabled" {
  description = "Enable Tooljet deployment"
  type        = bool
  default     = false
}

variable "argo_workflows_enabled" {
  description = "Enable Argo Workflows deployment"
  type        = bool
  default     = false
}

variable "argo_workflows_subdomain" {
  description = "Subdomain for Argo Workflows"
  type        = string
  default     = "argo-workflows"
}

variable "argo_workflows_rbac_rule" {
  description = "RBAC rule for Argo Workflows"
  type        = string
  default     = "false"
}

variable "argo_cd_enabled" {
  description = "Enable Argo CD deployment"
  type        = bool
  default     = false
}

variable "argo_cd_subdomain" {
  description = "Subdomain for Argo CD"
  type        = string
  default     = "argocd"
}

variable "windmill_enabled" {
  description = "Enable Windmill deployment"
  type        = bool
  default     = false
}

variable "kestra_enabled" {
  description = "Enable Kestra deployment"
  type        = bool
  default     = false
}

variable "kubernetes_dashboard_enabled" {
  description = "Enable Kubernetes Dashboard deployment"
  type        = bool
  default     = false
}

variable "kubernetes_config_path" {
  description = "Path to Kubernetes configuration file"
  type        = string
  default     = "~/.kube/config"
}

variable "google_oauth_client_id" {
  description = "Google OAuth client ID"
  type        = string
  default     = ""
}

variable "google_oauth_client_secret" {
  description = "Google OAuth client secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "domain_config_deployment_domain" {
  description = "Deployment domain for configurations"
  type        = string
  default     = ""
}

variable "domain_config_zone_domain" {
  description = "Zone domain for configurations"
  type        = string
  default     = ""
}

variable "prometheus_enabled" {
  description = "Enable Prometheus deployment"
  type        = bool
  default     = false
}

variable "ubuntu_enabled" {
  description = "Enable Ubuntu deployment"
  type        = bool
  default     = false
}

variable "configuration_postgres_enabled" {
  description = "Enable Configuration PostgreSQL deployment"
  type        = bool
  default     = false
}

variable "kubernetes_dashboard_chart_version" {
  description = "Kubernetes Dashboard chart version"
  type        = string
  default     = "7.5.0"
}

variable "prometheus_operator_chart_version" {
  description = "Prometheus Operator chart version"
  type        = string
  default     = "61.9.0"
}

variable "loki_chart_version" {
  description = "Loki chart version"
  type        = string
  default     = "2.10.0"
}

variable "argo_cd_chart_version" {
  description = "Argo CD chart version"
  type        = string
  default     = "7.4.3"
}

variable "lightdash_chart_version" {
  description = "Lightdash chart version"
  type        = string
  default     = "0.8.9"
}

variable "argo_workflows_chart_version" {
  description = "Argo Workflows chart version"
  type        = string
  default     = "0.42.3"
}

variable "dagster_chart_version" {
  description = "Dagster chart version"
  type        = string
  default     = "1.7.1"
}

variable "superset_chart_version" {
  description = "Superset chart version"
  type        = string
  default     = "0.12.9"
}

variable "windmill_chart_version" {
  description = "Windmill chart version"
  type        = string
  default     = "2.0.214"
}

variable "airbyte_chart_version" {
  description = "Airbyte chart version"
  type        = string
  default     = "1.1.0"
}

variable "airflow_chart_version" {
  description = "Airflow chart version"
  type        = string
  default     = "8.8.0"
}

variable "airbyte_enable_proxy" {
  description = "Enable OAuth2 Proxy"
  type        = bool
  default     = true
}

variable "airbyte_override_helm_values" {
  description = "Override helm values for Airbyte as YAML string"
  type        = string
  default     = ""
}

variable "clickhouse_enabled" {
  description = "Enable Clickhouse deployment"
  type        = bool
  default     = false
}

variable "clickhouse_chart_version" {
  description = "Clickhouse chart version"
  type        = string
  default     = "0.24.0"
}

variable "clickhouse_override_helm_values" {
  description = "Override helm values for Clickhouse as YAML string"
  type        = string
  default     = ""
}

variable "argo_workflows_override_helm_values" {
  description = "Override helm values for Argo Workflows as YAML string"
  type        = string
  default     = ""
}

variable "argo_cd_override_helm_values" {
  description = "Override helm values for Argo CD as YAML string"
  type        = string
  default     = ""
}

variable "dagster_override_helm_values" {
  description = "Override helm values for Dagster as YAML string"
  type        = string
  default     = ""
}

variable "superset_override_helm_values" {
  description = "List of Helm values files to override default configurations for Superset"
  type        = list(string)
  default     = []
}

variable "windmill_override_helm_values" {
  description = "List of Helm values files to override default configurations for Windmill"
  type        = list(string)
  default     = []
}

variable "prometheus_override_helm_values" {
  description = "List of Helm values files to override default configurations for Prometheus"
  type        = list(string)
  default     = []
}

variable "loki_override_helm_values" {
  description = "List of Helm values files to override default configurations for Loki"
  type        = list(string)
  default     = []
}

variable "lightdash_override_helm_values" {
  description = "List of Helm values files to override default configurations for Lightdash"
  type        = list(string)
  default     = []
}

variable "airflow_override_helm_values" {
  description = "List of Helm values files to override default configurations for Airflow"
  type        = list(string)
  default     = []
}
