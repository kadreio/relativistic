resource "helm_release" "windmill" {
  name       = "windmill"
  repository = "https://windmill-labs.github.io/windmill-helm-charts"
  chart      = "windmill"
  version    = "2.0.214"
  values     = [file("./${path.module}/helm_values.yaml")]

  timeout = 1200
}

resource "kubernetes_service" "expose_windmill_webserver" {
  metadata {
    name = "expose-workflows-webserver"
  }

  spec {
    type = "NodePort"
    port {
      port        = 8000
      target_port = 8000
      node_port   = 30085
    }

    selector = {
      "app.kubernetes.io/name" = "windmill-app"
    }
  }
}
