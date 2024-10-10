
resource "kubernetes_deployment" "ubuntu" {
  metadata {
    name = "ubuntu-deployment"
    labels = {
      app = "ubuntu"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "ubuntu"
      }
    }

    template {
      metadata {
        labels = {
          app = "ubuntu"
        }
      }

      spec {
        container {
          name  = "devcontainers-python"
          image = "mcr.microsoft.com/devcontainers/python:latest"

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          image_pull_policy = "IfNotPresent"
          command           = ["sleep", "infinity"]
        }
      }
    }
  }
}

resource "kubernetes_service" "ubuntu" {
  metadata {
    name = "ubuntu-service"
    labels = {
      app = "ubuntu"
    }
  }

  spec {
    selector = {
      app = "ubuntu"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
