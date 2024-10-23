terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.21.0"
    }
  }
}


module "configuration_postgres" {
    count  = var.configuration_postgres_enabled ? 1 : 0
    source = "./modules/configuration_postgres"
}

module "airbyte" {
    count  = var.airbyte_enabled ? 1 : 0
    source = "./modules/airbyte"
    google_oauth_client_id = var.google_oauth_client_id
    google_oauth_client_secret = var.google_oauth_client_secret
    target_domain = "${var.airbyte_subdomain}.${var.domain_config_deployment_domain}"
    db_host = var.airbyte_postgres_host
    db_port = var.airbyte_postgres_port
    db_name = var.airbyte_postgres_name
    db_user = var.airbyte_postgres_user
    db_password = var.airbyte_postgres_password
    userlist = var.airbyte_userlist
    use_external_pg = var.airbyte_use_external_pg
    airbyte_chart_version = var.airbyte_chart_version
    enable_proxy = var.airbyte_enable_proxy
    override_helm_values = var.airbyte_override_helm_values
}

module "airflow" {
    count  = var.airflow_enabled ? 1 : 0
    source = "./modules/airflow"
    airflow_chart_version = var.airflow_chart_version
    override_helm_values = var.airflow_override_helm_values
}

module "analytics_postgres" {
    count  = var.analytics_postgres_enabled ? 1 : 0
    source = "./modules/analytics_postgres"
}

module "dagster" {
    count  = var.dagster_enabled ? 1 : 0
    source = "./modules/dagster"
    dagster_chart_version = var.dagster_chart_version
    override_helm_values = var.dagster_override_helm_values
}

module "lightdash" {
    count  = var.lightdash_enabled ? 1 : 0
    source = "./modules/lightdash"
    lightdash_chart_version = var.lightdash_chart_version
    override_helm_values = var.lightdash_override_helm_values
}

module "argo_workflows" {
    count  = var.argo_workflows_enabled ? 1 : 0
    source = "./modules/argo_workflows"
    google_oauth_client_id = var.google_oauth_client_id
    google_oauth_client_secret = var.google_oauth_client_secret
    target_domain = "${var.argo_workflows_subdomain}.${var.domain_config_deployment_domain}"
    rbac_rule = var.argo_workflows_rbac_rule
    argo_workflows_chart_version = var.argo_workflows_chart_version
    override_helm_values = var.argo_workflows_override_helm_values
}

module "argo_cd" {
    count  = var.argo_cd_enabled ? 1 : 0
    source = "./modules/argo_cd"
    google_oauth_client_id = var.google_oauth_client_id
    google_oauth_client_secret = var.google_oauth_client_secret
    target_domain = "${var.argo_cd_subdomain}.${var.domain_config_deployment_domain}"
    argo_cd_chart_version = var.argo_cd_chart_version
    override_helm_values = var.argo_cd_override_helm_values
}

module "windmill" {
    count  = var.windmill_enabled ? 1 : 0
    source = "./modules/windmill"
    windmill_chart_version = var.windmill_chart_version
    override_helm_values = var.windmill_override_helm_values
}

### Infra

module "kubernetes_dashboard" {
    count  = var.kubernetes_dashboard_enabled ? 1 : 0
    source = "./modules/kubernetes-dashboard"
    kubernetes_dashboard_chart_version = var.kubernetes_dashboard_chart_version
}

module "prometheus" {
    count  = var.prometheus_enabled ? 1 : 0
    source = "./modules/prometheus"
    prometheus_operator_chart_version = var.prometheus_operator_chart_version
    loki_chart_version = var.loki_chart_version
    prometheus_override_helm_values = var.prometheus_override_helm_values
    loki_override_helm_values = var.loki_override_helm_values
}

module "superset" {
    count  = var.superset_enabled ? 1 : 0
    source = "./modules/superset"
    superset_default_user = var.superset_default_user
    superset_default_password = var.superset_default_password
    superset_secret_key = var.superset_secret_key
    superset_local_exposed_port = var.superset_local_exposed_port
    superset_chart_version = var.superset_chart_version
    override_helm_values = var.superset_override_helm_values
}

module "ubuntu" {
    count  = var.ubuntu_enabled ? 1 : 0
    source = "./modules/ubuntu"
}

module "clickhouse" {
    count  = var.clickhouse_enabled ? 1 : 0
    source = "./modules/clickhouse"
    clickhouse_chart_version = var.clickhouse_chart_version
    override_helm_values = var.clickhouse_override_helm_values
}
