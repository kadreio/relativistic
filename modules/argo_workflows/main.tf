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

variable "auth_mode" {
  type = string
  default = "server"
  description = "The authentication mode for Argo Workflows. Options: server, sso, client"
}

variable "allowed_domains" {
  type = list(string)
  default = []
  description = "The domains that are allowed to access Argo Workflows"
}

variable "rbac_rule" {
  type = string
  default = "false"
  description = "Rule to validate if a user should be logged in as admin."
}

resource "kubernetes_service_account" "admin_argo" {
  metadata {
    name = "admin-argo"
    annotations = {
      "workflows.argoproj.io/rbac-rule" = var.rbac_rule
      "workflows.argoproj.io/rbac-rule-precedence" = "1"
    }
  }
  
}

resource "helm_release" "argo_workflows" {
  name       = "argo-workflows"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-workflows"
  version    = "0.42.3"
  values     = [templatefile("./${path.module}/helm_values.yaml", {
    target_domain               = "${var.target_domain}"
    auth_mode = var.auth_mode
  })]
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

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.admin_argo.metadata[0].name
    namespace = kubernetes_service_account.admin_argo.metadata[0].namespace
  }
}

resource "kubernetes_service_account" "other_argo" {
  metadata {
    name = "other-argo"
    annotations = {
      "workflows.argoproj.io/rbac-rule" = "true"
      "workflows.argoproj.io/rbac-rule-precedence" = "0"
    }
  }
}
resource "kubernetes_secret" "other-argo-service-account-token" {
  metadata {
    name = "other-argo.service-account-token"
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.other_argo.metadata[0].name
    }
  }
  
  type = "kubernetes.io/service-account-token"

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

variable "target_domain" {
  description = "The url of the deployed application"
  type        = string
  default     = "localhost:30083"
}

variable "argo_workflows_subdomain" {
  description = "The subdomain for Argo Workflows"
  type        = string
  default     = "argo-workflows"
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

resource "kubernetes_secret" "admin-argo-service-account-token" {
  metadata {
    name = "admin-argo.service-account-token"
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.admin_argo.metadata[0].name
    }
  }
  
  type = "kubernetes.io/service-account-token"

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

