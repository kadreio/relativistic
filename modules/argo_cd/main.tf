resource "helm_release" "argo_cd" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argo_cd_chart_version
  force_update = true
  values     = [
    templatefile("${path.module}/helm_values.yaml", {
      google_oauth_client_id     = var.google_oauth_client_id
      google_oauth_client_secret = var.google_oauth_client_secret
      target_domain              = var.target_domain
    }),
    var.override_helm_values
  ]
  timeout = 1200
}

resource "kubernetes_service" "expose_argo_cd_webserver" {
  metadata {
    name = "expose-argo-cd-webserver"
  }

  spec {
    type = "NodePort"
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30088
    }

    selector = {
      "app.kubernetes.io/name" = "argocd-server"
    }
  }
}
