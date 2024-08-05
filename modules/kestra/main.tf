resource "helm_release" "kestra" {
  name       = "kestra"
  repository = "https://helm.kestra.io"
  chart      = "kestra"
  version    = "0.17.0"
}

resource "kubernetes_service" "expose_kestra_webserver" {
  metadata {
    name = "expose-kestra-webserver"
  }

  spec {
    type = "NodePort"
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30086
    }

    selector = {
      "app.kubernetes.io/name" = "kestra"
    }
  }
}
