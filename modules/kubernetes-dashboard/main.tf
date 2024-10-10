variable "kubernetes_dashboard_chart_version" {
  description = "Kubernetes Dashboard chart version"
  type        = string
  default     = "7.5.0"
}

resource "helm_release" "kubernetes_dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard"
  chart      = "kubernetes-dashboard"
  version    = var.kubernetes_dashboard_chart_version
  force_update = true

  # values = [
  #   templatefile("${path.module}/helm_values.yaml")
  # ]
}

resource "kubernetes_service_account" "all_access" {
  metadata {
    name      = "all-access-sa"
    namespace = "default"
  }
}

resource "kubernetes_cluster_role" "superuser" {
  metadata {
    name = "superuser-access"
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "superuser_binding" {
  metadata {
    name = "superuser-access-binding"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.all_access.metadata[0].name
    namespace = "default"
  }

  role_ref {
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.superuser.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}

# $ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/${DASHBOARD_VERSION}/aio/deploy/recommended.yaml

# resource "kubernetes_service" "expose_superset_webserver_external" {
#   metadata {
#     name = "expose-superset-webserver-external"
#     annotations = {
#       "service.beta.kubernetes.io/aws-load-balancer-ssl-cert" = aws_acm_certificate.cert.arn
#       "service.beta.kubernetes.io/aws-load-balancer-backend-protocol" = "http"
#       "service.beta.kubernetes.io/aws-load-balancer-ssl-ports" = "443"
#       "service.beta.kubernetes.io/aws-load-balancer-type" = "alb"
#     }
#   }

#   spec {
#     type = "LoadBalancer"
#     port {
#       port        = 443
#       target_port = 8088
#     }

#     selector = {
#       app = "superset"
#     }
#   }
# } 
