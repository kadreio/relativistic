resource "helm_release" "airbyte" {
  name       = "airbyte"
  repository = "https://airbytehq.github.io/helm-charts"
  chart      = "airbyte"
  version    = "0.64.81"
  values     = [file("./${path.module}/airbyte.yaml")]
}

resource "kubernetes_service" "expose_airbyte_webeserver" {
  metadata {
    name = "expose-airbyte-webeserver"
  }

  spec {
    type = "NodePort"
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30080
    }

    selector = {
      airbyte_deploy = "webapp"
    }
  }
}
