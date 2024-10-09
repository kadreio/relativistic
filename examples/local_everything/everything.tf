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


resource "helm_release" "kube_state_metrics" {
  name       = "kube-state-metrics"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-state-metrics"
  namespace  = "kube-system"
  version    = "5.15.2"  # You can specify a version or omit for the latest

  set {
    name  = "autosharding.enabled"
    value = "true"
  }

  set {
    name  = "metricLabelsAllowlist[0]"
    value = "pods=[*]"
  }

  set {
    name  = "metricAnnotationsAllowList[0]"
    value = "pods=[*]"
  }
}

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.11.0"  # You can specify a version or omit for the latest

  set {
    name  = "args[0]"
    value = "--kubelet-insecure-tls"
  }

  set {
    name  = "args[1]"
    value = "--kubelet-preferred-address-types=InternalIP"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }
}

module "relativistic" {
    source = "../../"
    superset_enabled = true
    superset_default_password = "starting_password_to_change"
    superset_default_user = "you@yourcompany.com"

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
    prometheus_enabled = true

 
    google_oauth_client_id = "test"
    google_oauth_client_secret = "test"
}

