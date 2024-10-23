variable "windmill_chart_version" {
  description = "Windmill chart version"
  type        = string
  default     = "2.0.214"
}

variable "override_helm_values" {
  description = "List of Helm values files to override default configurations for Windmill"
  type        = list(string)
  default     = []
}

resource "helm_release" "windmill" {
  name       = "windmill"
  repository = "https://windmill-labs.github.io/windmill-helm-charts"
  chart      = "windmill"
  version    = var.windmill_chart_version
  force_update = true

  timeout = 1200

  values = var.override_helm_values
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
