resource "kubernetes_service_account" "argo_server" {
  metadata {
    name = "argo-server"
  }
}

resource "kubernetes_cluster_role" "argo_server_cluster_role" {
  metadata {
    name = "argo-server-cluster-role"
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["get", "watch", "list"]
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "create"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/exec", "pods/log"]
    verbs      = ["get", "list", "watch", "delete"]
  }

  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["watch", "create", "patch"]
  }

  rule {
    api_groups = [""]
    resources  = ["serviceaccounts"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["argoproj.io"]
    resources = [
      "eventsources",
      "sensors",
      "workflows",
      "workfloweventbindings",
      "workflowtemplates",
      "cronworkflows",
      "clusterworkflowtemplates"
    ]
    verbs = ["create", "get", "list", "watch", "update", "patch", "delete"]
  }
}


resource "kubernetes_cluster_role_binding" "argo_server_binding" {
  metadata {
    name = "argo-server-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "argo-server-cluster-role"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argo_server.metadata[0].name
    namespace = kubernetes_service_account.argo_server.metadata[0].namespace
  }
}


resource "helm_release" "argo_workflows" {
  name       = "argo-workflows"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-workflows"
  version    = "0.41.14"
  values     = [templatefile("./${path.module}/helm_values.yaml", {
    deployed_url               = var.deployed_url
  })]
  timeout    = "60"
}

resource "kubernetes_cluster_role" "super_admin" {
  metadata {
    name = "super-admin"
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "super_admin_binding" {
  metadata {
    name = "super-admin-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.super_admin.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = "sso-super-admins"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argo_server.metadata[0].name
    namespace = kubernetes_service_account.argo_server.metadata[0].namespace
  }
}

variable "google_oauth_client_id" {
  description = "Google OAuth client ID"
  type        = string
  default     = ""
}

variable "google_oauth_client_secret" {
  description = "Google OAuth client secret"
  type        = string
  default     = ""
}

variable "deployed_url" {
  description = "The url of the deployed application"
  type        = string
  default     = "localhost:30083"
}



resource "kubernetes_secret" "argo_sso" {
  metadata {
    name = "argo-sso"
  }

  data = {
    "clientId"     = var.google_oauth_client_id
    "clientSecret" = var.google_oauth_client_secret
  }
}

resource "kubernetes_service" "expose_argo_workflows_webserver" {
  metadata {
    name = "expose-argo-workflows-webserver"
  }

  spec {
    type = "NodePort"
    port {
      port        = 2746
      target_port = 2746
      node_port   = 30083
    }

    selector = {
      "app" = "argo_webserver"
    }
  }
}

