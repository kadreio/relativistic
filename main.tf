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
}

module "airflow" {
    count  = var.airflow_enabled ? 1 : 0
    source = "./modules/airflow"
}

module "analytics_postgres" {
    count  = var.analytics_postgres_enabled ? 1 : 0
    source = "./modules/analytics_postgres"
}

module "dagster" {
    count  = var.dagster_enabled ? 1 : 0
    source = "./modules/dagster"
}

module "lightdash" {
    count  = var.lightdash_enabled ? 1 : 0
    source = "./modules/lightdash"
}

module "argo_workflows" {
    count  = var.argo_workflows_enabled ? 1 : 0
    source = "./modules/argo_workflows"
    google_oauth_client_id = var.google_oauth_client_id
    google_oauth_client_secret = var.google_oauth_client_secret
    target_domain = "${var.argo_workflows_subdomain}.${var.domain_config_deployment_domain}"
    rbac_rule = var.argo_workflows_rbac_rule
}

module "argo_cd" {
    count  = var.argo_cd_enabled ? 1 : 0
    source = "./modules/argo_cd"
    google_oauth_client_id = var.google_oauth_client_id
    google_oauth_client_secret = var.google_oauth_client_secret
    target_domain = "${var.argo_cd_subdomain}.${var.domain_config_deployment_domain}"
}

module "windmill" {
    count  = var.windmill_enabled ? 1 : 0
    source = "./modules/windmill"
}

### Infra

module "kubernetes_dashboard" {
    count  = var.kubernetes_dashboard_enabled ? 1 : 0
    source = "./modules/kubernetes-dashboard"
}

module "prometheus" {
    count  = var.prometheus_enabled ? 1 : 0
    source = "./modules/prometheus"
}

module "superset" {
    count  = var.superset_enabled ? 1 : 0
    source = "./modules/superset"
    superset_default_user = var.superset_default_user
    superset_default_password = var.superset_default_password
    superset_secret_key = var.superset_secret_key
    superset_local_exposed_port = var.superset_local_exposed_port
}