resource "helm_release" "airflow" {
  name       = "airflow"
  repository = "https://airflow-helm.github.io/charts"
  chart      = "airflow"
  version    = "8.8.0"
  values     = [file("./${path.module}/helm_values.yaml")]
  timeout = 1200
}

resource "kubernetes_service" "expose_airflow_webserver" {
  metadata {
    name = "expose-airflow-webeserver"
  }

  spec {
    type = "NodePort"
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30081
    }

    selector = {
      app= "airflow"
      component= "web"
    }
  }
}
