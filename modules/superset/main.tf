resource "helm_release" "superset" {
  name       = "superset"
  repository = "https://apache.github.io/superset"
  chart      = "superset"
  version    = "0.12.9"

  values = [
    templatefile("${path.module}/helm_values.yaml", { superset_default_user = var.superset_default_user, superset_default_password = var.superset_default_password, superset_secret_key = var.superset_secret_key})
  ]
}

resource "kubernetes_service" "expose_superset_webserver" {
  metadata {
    name = "expose-superset-webserver"
  }

  spec {
    type = "NodePort"
    port {
      port        = 8088
      target_port = 8088
      node_port   = 30082
    }

    selector = {
      app= "superset"
    }
  }
}
