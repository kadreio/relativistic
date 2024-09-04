resource "helm_release" "airbyte" {
  name       = "airbyte"
  repository = "https://airbytehq.github.io/helm-charts"
  chart      = "airbyte"
  version    = "0.383.1"
  values     = [file("./${path.module}/airbyte.yaml")]
}

resource "kubernetes_service" "expose_airbyte_webserver" {
  metadata {
    name = "expose-airbyte-webserver"
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

variable "google_oauth_client_id" {
  description = "Google OAuth client ID"
  type        = string
  default     = ""
}

variable "google_oauth_client_secret" {
  description = "Google OAuth client secret"
  type        = string
  default     = ""
}

variable "target_domain" {
  description = "The url of the deployed application"
  type        = string
  default     = "localhost:30083"
}

variable "airbyte_subdomain" {
  description = "The subdomain for Airbyte"
  type        = string
  default     = "airbyte"
}

variable "deployment_domain" {
  description = "The deployment domain"
  type        = string
  default     = ""
}

resource "helm_release" "oauth2_proxy" {
  name             = "oauth2-proxy-airbyte"
  repository       = "https://oauth2-proxy.github.io/manifests"
  chart            = "oauth2-proxy"

  
  values = [templatefile("./${path.module}/oauth2_proxy.yaml", {
    google_oauth_client_id     = var.google_oauth_client_id
    google_oauth_client_secret = var.google_oauth_client_secret
    target_domain               = var.target_domain
  })]
}

resource "kubernetes_service" "expose_proxy" {
  metadata {
    name = "expose-proxy"
  }

  spec {
    type = "NodePort"
    port {
      port        = 4180
      target_port = 4180
      node_port   = 30087
    }

    selector = {
      app = "oauth2-proxy-airbyte"
    }
  }
}