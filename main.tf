provider "kubernetes" {
  config_path              = "~/.kube/config"
  config_context_cluster   = "minikube"
}

resource "kubernetes_namespace" "minikube_namespace" {
  metadata {
    name = "terraform-namespace"
  }
}

module "airbyte" {
    count  = var.airbyte_enabled ? 1 : 0
    source = "./modules/airbyte"
}

module "airflow" {
    count  = var.airflow_enabled ? 1 : 0
    source = "./modules/airflow"
}

module "superset" {
    count  = var.superset_enabled ? 1 : 0
    source = "./modules/superset"
    superset_default_user = var.superset_default_user
    superset_default_password = var.superset_default_password
    superset_secret_key = var.superset_secret_key
}

module "analytics_postgres" {
    count  = var.analytics_postgres_enabled ? 1 : 0
    source = "./modules/analytics_postgres"
}

module "dagster" {
    count  = var.dagster_enabled ? 1 : 0
    source = "./modules/dagster"
}

module "tooljet" {
    count  = var.tooljet_enabled ? 1 : 0
    source = "./modules/tooljet"
}

module "lightdash" {
    count  = var.lightdash_enabled ? 1 : 0
    source = "./modules/lightdash"
}

module "jitsu" {
    count  = var.lightdash_enabled ? 1 : 0
    source = "./modules/jitsu"
}

module "argo_workflows" {
    count  = var.argo_workflows_enabled ? 1 : 0
    source = "./modules/argo_workflows"
}

module "windmill" {
    count  = var.windmill_enabled ? 1 : 0
    source = "./modules/windmill"
}