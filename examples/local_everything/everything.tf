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
    source = "../../"
    superset_enabled = true
    superset_default_password = "starting_password_to_change"
    superset_default_user = "you@yourcompany.com"

    airbyte_chart_version = "1.1.0"
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

    ubuntu_enabled = true
    windmill_enabled = true
    prometheus_enabled = false

 
    google_oauth_client_id = "test"
    google_oauth_client_secret = "test"
}

