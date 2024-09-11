variable "airbyte" {
  description = "Configuration for Airbyte deployment"
  type = object({
    enabled = bool
    postgres = object({
      host     = string
      port     = number
      name     = string
      user     = string
      password = string
    })
    subdomain = string
    userlist  = string
  })
  default = {
    enabled = false
    postgres = {
      host     = null
      port     = 5432
      name     = null
      user     = null
      password = null
    }
    subdomain = "airbyte"
    userlist  = ""
  }
  sensitive = true
}

variable "superset" {
  description = "Configuration for Apache Superset deployment"
  type = object({
    enabled         = bool
    default_user    = string
    default_password = string
    secret_key      = string
  })
  default = {
    enabled         = false
    default_user    = "admin@superset.com"
    default_password = "admin"
    secret_key      = "YOUR_OWN_RANDOM_GENERATED_SECRET_KEY"
  }
}

variable "airflow" {
  description = "Configuration for Apache Airflow deployment"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "analytics_postgres" {
  description = "Configuration for Analytics PostgreSQL deployment"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "dagster" {
  description = "Configuration for Dagster deployment"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "lightdash" {
  description = "Configuration for Lightdash deployment"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "tooljet" {
  description = "Configuration for Tooljet deployment"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "jitsu" {
  description = "Configuration for Jitsu deployment"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "argo_workflows" {
  description = "Configuration for Argo Workflows deployment"
  type = object({
    enabled   = bool
    subdomain = string
    rbac_rule = string
  })
  default = {
    enabled   = false
    subdomain = "argo-workflows"
    rbac_rule = "false"
  }
}

variable "argo_cd" {
  description = "Configuration for Argo CD deployment"
  type = object({
    enabled   = bool
    subdomain = string
  })
  default = {
    enabled   = false
    subdomain = "argocd"
  }
}

variable "windmill" {
  description = "Configuration for Windmill deployment"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "kestra" {
  description = "Configuration for Kestra deployment"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "kubernetes_dashboard" {
  description = "Configuration for Kubernetes Dashboard deployment"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "kubernetes_config" {
  description = "Kubernetes configuration settings"
  type = object({
    config_path = string
  })
  default = {
    config_path = "~/.kube/config"
  }
}

variable "google_oauth" {
  description = "Google OAuth configuration for authentication"
  type = object({
    client_id     = string
    client_secret = string
  })
  default = {
    client_id     = ""
    client_secret = ""
  }
}

variable "domain_config" {
  description = "Domain configuration for deployments"
  type = object({
    deployment_domain = string
    zone_domain       = string
  })
  default = {
    deployment_domain = ""
    zone_domain       = ""
  }
}