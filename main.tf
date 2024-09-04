module "configuration_postgres" {
    source = "./modules/configuration_postgres"
}

module "airbyte" {
    count  = var.airbyte_enabled ? 1 : 0
    source = "./modules/airbyte"
    google_oauth_client_id = var.google_oauth_client_id
    google_oauth_client_secret =  var.google_oauth_client_secret
    target_domain = "airbyte.${var.deployment_domain}"
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
    google_oauth_client_id = var.google_oauth_client_id
    google_oauth_client_secret =  var.google_oauth_client_secret
    target_domain = "${var.argo_workflows_subdomain}.${var.deployment_domain}"
}

module "argo_cd" {
    count  = var.argo_cd_enabled ? 1 : 0
    source = "./modules/argo_cd"
    google_oauth_client_id = var.google_oauth_client_id
    google_oauth_client_secret =  var.google_oauth_client_secret
    target_domain = "${var.argocd_subdomain}.${var.deployment_domain}"
}

module "windmill" {
    count  = var.windmill_enabled ? 1 : 0
    source = "./modules/windmill"
}

module "kestra" {
    count  = var.kestra_enabled ? 1 : 0
    source = "./modules/kestra"
}

### Infra

module "kubernetes_dashboard" {
    count  = var.kubernetes_dashboard_enabled ? 1 : 0
    source = "./modules/kubernetes-dashboard"
}

module "prometheus" {
    source = "./modules/prometheus"
}

# terraform {
#   required_version = ">= 1.1.6"
#   required_providers {
#     postgresql = { # This line is what needs to change.
#       source = "cyrilgdn/postgresql"
#       version = "1.22.0"
#     }
#   }
# }

# resource "postgresql_role" "new_user" {
#   name     = "new_user"
#   login    = true
#   password = "new_user_password"
# }

# resource "postgresql_database" "new_database" {
#   name              = "new_database"
#   owner             = postgresql_role.new_user.name
#   template          = "template0"
#   connection_limit  = -1
#   allow_connections = true
# }

# resource "postgresql_grant" "new_user_grant" {
#   database    = postgresql_database.new_database.name
#   role        = postgresql_role.new_user.name
#   schema      = "public"
#   object_type = "database"
#   privileges  = ["ALL"]
# }

module "superset" {
    count  = var.superset_enabled ? 1 : 0
    source = "./modules/superset"
    superset_default_user = var.superset_default_user
    superset_default_password = var.superset_default_password
    superset_secret_key = var.superset_secret_key
}