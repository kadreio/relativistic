resource "helm_release" "airflow" {
  name       = "airflow"
  repository = "https://airflow-helm.github.io/charts"
  chart      = "airflow"
  version    = "8.8.0"
}

resource "kubernetes_service" "expose_airflow_webeserver" {
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
