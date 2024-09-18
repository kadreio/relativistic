provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

variable "superset_default_user" {
    type = string
    default = "admin"
}

variable "superset_default_password" {
    type = string
    default = "admin"
}


module "relativistic" {
    source = "github.com/kadreio/relativistic.git?ref=v0.0.4-rc1"

    kubernetes_dashboard_enabled = true
    kubernetes_config_path = "~/.kube/config"

    superset_enabled = true
    superset_default_user = var.superset_default_user
    superset_default_password = var.superset_default_password
    superset_local_exposed_port = 30086

    airbyte_enabled = true
    airbyte_userlist = <<EOF
        fake@example.com
        fake2@example.com
      EOF 

    airflow_enabled = true

    analytics_postgres_enabled = true

    lightdash_enabled = true

    argo_workflows_enabled = true
    argo_workflows_subdomain = "argo-workflows"
    argo_workflows_rbac_rule = "false"

    argo_cd_enabled = true
    argo_cd_subdomain = "argocd"

    windmill_enabled = true

    google_oauth_client_id = "1234567890"
    google_oauth_client_secret = "1234567890"

}