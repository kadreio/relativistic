module "aws" {
    source = "./modules/aws"
    domain_root = "kadre.io"
    subdomain = "${var.deployment_domain}"
}

provider "helm" {
  kubernetes {
    host                   = module.aws.cluster_endpoint
    token                  = module.aws.cluster_auth_cluster_token
    cluster_ca_certificate = module.aws.cluster_ca_certificate
  }
}

provider "kubernetes" {
    host                   = module.aws.cluster_endpoint
    token                  = module.aws.cluster_auth_cluster_token
    cluster_ca_certificate = module.aws.cluster_ca_certificate
}

# provider "helm" {
#     kubernetes {
#         config_path = "~/.kube/config"
#     }
# }

# provider "kubernetes" {
#     config_path = "~/.kube/config"
# }

# resource "kubernetes_namespace" "minikube_namespace" {
#   metadata {
#     name = "terraform-namespace"
#   }
# }

module "configuration_postgres" {
    source = "./modules/configuration_postgres"
}

module "airbyte" {
    count  = var.airbyte_enabled ? 1 : 0
    source = "./modules/airbyte"
    google_oauth_client_id = var.google_oauth_client_id
    google_oauth_client_secret = var.google_oauth_client_secret
    deployed_url = "https://airbyte.${var.deployment_domain}"
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
    google_oauth_client_id = var.google_oauth_client_id
    google_oauth_client_secret = var.google_oauth_client_secret
    deployed_url = "https://argo-workflows.${var.deployment_domain}"
}

module "argo_cd" {
    count  = var.argo_cd_enabled ? 1 : 0
    source = "./modules/argo_cd"
    google_oauth_client_id = var.google_oauth_client_id
    google_oauth_client_secret = var.google_oauth_client_secret
    deployed_url = "https://argocd.${var.deployment_domain}"
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