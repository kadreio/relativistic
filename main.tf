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
    count  = var.airbyte.enabled ? 1 : 0
    source = "./modules/airbyte"
    google_oauth_client_id = var.google_oauth.client_id
    google_oauth_client_secret = var.google_oauth.client_secret
    target_domain = "${var.airbyte.subdomain}.${var.domain_config.deployment_domain}"
    db_host = var.airbyte.postgres.host
    db_port = var.airbyte.postgres.port
    db_name = var.airbyte.postgres.name
    db_user = var.airbyte.postgres.user
    db_password = var.airbyte.postgres.password
    userlist = var.airbyte.userlist
}

module "airflow" {
    count  = var.airflow.enabled ? 1 : 0
    source = "./modules/airflow"
}

module "analytics_postgres" {
    count  = var.analytics_postgres.enabled ? 1 : 0
    source = "./modules/analytics_postgres"
}

module "dagster" {
    count  = var.dagster.enabled ? 1 : 0
    source = "./modules/dagster"
}

module "lightdash" {
    count  = var.lightdash.enabled ? 1 : 0
    source = "./modules/lightdash"
}

module "argo_workflows" {
    count  = var.argo_workflows.enabled ? 1 : 0
    source = "./modules/argo_workflows"
    google_oauth_client_id = var.google_oauth.client_id
    google_oauth_client_secret = var.google_oauth.client_secret
    target_domain = "${var.argo_workflows.subdomain}.${var.domain_config.deployment_domain}"
    rbac_rule = var.argo_workflows.rbac_rule
}

module "argo_cd" {
    count  = var.argo_cd.enabled ? 1 : 0
    source = "./modules/argo_cd"
    google_oauth_client_id = var.google_oauth.client_id
    google_oauth_client_secret = var.google_oauth.client_secret
    target_domain = "${var.argo_cd.subdomain}.${var.domain_config.deployment_domain}"
}

module "windmill" {
    count  = var.windmill.enabled ? 1 : 0
    source = "./modules/windmill"
}

### Infra

module "kubernetes_dashboard" {
    count  = var.kubernetes_dashboard.enabled ? 1 : 0
    source = "./modules/kubernetes-dashboard"
}

module "prometheus" {
    source = "./modules/prometheus"
}

module "superset" {
    count  = var.superset.enabled ? 1 : 0
    source = "./modules/superset"
    superset_default_user = var.superset.default_user
    superset_default_password = var.superset.default_password
    superset_secret_key = var.superset.secret_key
    superset_local_exposed_port = var.superset.local_exposed_port
}