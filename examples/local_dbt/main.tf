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
    argo_workflows_enabled = true
    argo_workflows_subdomain = "argo-workflows"
    argo_workflows_rbac_rule = "false"
}


resource "kubernetes_secret" "git_credentials" {
  metadata {
    name = "git-credentials"
  }

  data = {
    username = var.git_username
    sshPrivateKeySecret = var.git_ssh_private_key
  }

  type = "Opaque"
}

variable "git_username" {
  description = "Username for Git authentication"
  type        = string
  sensitive   = true
  default = "dylan@kadre.io"
}

variable "git_ssh_private_key" {
  description = "SSH private key for Git authentication"
  type        = string
  sensitive   = true
}
