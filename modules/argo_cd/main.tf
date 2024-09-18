resource "helm_release" "argo_cd" {
  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.4.3"
  values     = [templatefile("./${path.module}/helm_values.yaml", {
    google_oauth_client_id     = var.google_oauth_client_id
    google_oauth_client_secret = var.google_oauth_client_secret
    target_domain               = var.target_domain
  })]
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
  default     = "localhost:30088"
}


resource "kubernetes_service" "expose_argo_cd_webserver" {
  metadata {
    name = "expose-argo-cd-webserver"
  }

  spec {
    type = "NodePort"
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30088
    }

    selector = {
      "app.kubernetes.io/name" = "argocd-server"
    }
  }
}

