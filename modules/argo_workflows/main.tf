resource "helm_release" "argo_workflows" {
  name       = "argo-workflows"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-workflows"
  version    = "0.41.8"
  values     = [file("./${path.module}/helm_values.yaml")]
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
