resource "kubernetes_secret" "db_secrets" {
  metadata {
    name = "db-secrets"
  }

  type = "Opaque"

  data = {
    DATABASE_PASSWORD = var.db_password
  }
}

variable "airbyte_chart_version" {
  description = "Airbyte chart version"
  type        = string
  default     = "1.1.0"
}

resource "helm_release" "airbyte" {
  name       = "airbyte"
  repository = "https://airbytehq.github.io/helm-charts"
  chart      = "airbyte"
  version    = var.airbyte_chart_version
  force_update = true
  values     = [
    templatefile("./${path.module}/airbyte.yaml", {
      db_host     = var.db_host
      db_port     = var.db_port
      db_name     = var.db_name
      db_user     = var.db_user
      db_password = var.db_password
      use_external_pg = var.use_external_pg
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
      "relativistic-app" = "airbyte"
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
  default     = "localhost:30080"
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
  default     = "airbyte-postgresql"
}

variable "db_port" {
  description = "PostgreSQL database port"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
  default     = "airbyte"

}

variable "db_user" {
  description = "PostgreSQL database user"
  type        = string
  default     = "airbyte"
}

variable "db_password" {
  description = "PostgreSQL database password"
  type        = string
  default     = ""
}

variable "userlist" {
  description = "Newline delimeted list of users that can access the service"
  type        = string
  default     = <<EOF
        fake@example.com
        fake2@example.com
      EOF 
}

variable "use_external_pg" {
  description = "Use external PostgreSQL for Airbyte"
  type        = bool
  default     = false
}


variable "cookie_secret" {
  description = "Random value to use as a cookie secret for OAuth2 Proxy"
  type        = string
  default     = ""
}

resource "random_string" "cookie_secret" {
  length  = 32
  special = false
}

variable "enable_proxy" {
  description = "Enable OAuth2 proxy for Airbyte"
  type        = bool
  default     = true
}

resource "helm_release" "oauth2_proxy" {
  count      = var.enable_proxy ? 1 : 0
  name       = "oauth2-proxy-airbyte"
  repository = "https://oauth2-proxy.github.io/manifests"
  chart      = "oauth2-proxy"

  values = [templatefile("./${path.module}/oauth2_proxy.yaml", {
    google_oauth_client_id     = var.google_oauth_client_id
    google_oauth_client_secret = var.google_oauth_client_secret
    target_domain              = var.target_domain
    userlist                   = var.userlist
    cookie_secret              = random_string.cookie_secret.result
  })]
}

resource "kubernetes_service" "expose_proxy" {
  count = var.enable_proxy ? 1 : 0
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
