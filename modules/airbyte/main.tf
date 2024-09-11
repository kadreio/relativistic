resource "kubernetes_secret" "db_secrets" {
  metadata {
    name = "db-secrets"
  }

  type = "Opaque"

  data = {
    DATABASE_PASSWORD = var.db_password
  }
}


resource "helm_release" "airbyte" {
  name       = "airbyte"
  repository = "https://airbytehq.github.io/helm-charts"
  chart      = "airbyte"
  version    = "0.453.2"
  values     = [
    templatefile("./${path.module}/airbyte.yaml", {
      db_host     = var.db_host
      db_port     = var.db_port
      db_name     = var.db_name
      db_user     = var.db_user
      db_password = var.db_password
    })
  ]
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
variable "db_host" {
  description = "PostgreSQL database host"
  type        = string
}

variable "db_port" {
  description = "PostgreSQL database port"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
}

variable "db_user" {
  description = "PostgreSQL database user"
  type        = string
}

variable "db_password" {
  description = "PostgreSQL database password"
  type        = string
}

variable "userlist" {
  description = "Newline delimeted list of users that can access the service"
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
    userlist    = var.userlist
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