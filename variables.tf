variable "airbyte" {
  description = "Airbyte configuration"
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
  }
  sensitive = true
}

variable "superset" {
  description = "Superset configuration"
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
  description = "Airflow configuration"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "analytics_postgres" {
  description = "Analytics Postgres configuration"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "dagster" {
  description = "Dagster configuration"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "lightdash" {
  description = "Lightdash configuration"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "tooljet" {
  description = "Tooljet configuration"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "jitsu" {
  description = "Jitsu configuration"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "argo_workflows" {
  description = "Argo Workflows configuration"
  type = object({
    enabled   = bool
    subdomain = string
  })
  default = {
    enabled   = false
    subdomain = "argo-workflows"
  }
}

variable "argo_cd" {
  description = "Argo CD configuration"
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
  description = "Windmill configuration"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "kestra" {
  description = "Kestra configuration"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "kubernetes_dashboard" {
  description = "Kubernetes Dashboard configuration"
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "kubernetes_config" {
  description = "Kubernetes configuration"
  type = object({
    config_path = string
  })
  default = {
    config_path = "~/.kube/config"
  }
}

variable "google_oauth" {
  description = "Google OAuth configuration"
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
  description = "Domain configuration"
  type = object({
    deployment_domain = string
    zone_domain       = string
  })
  default = {
    deployment_domain = ""
    zone_domain       = ""
  }
}

# variable "airbyte_postgres" {
#   description = "Airbyte PostgreSQL configuration"
#   type = object({
#     host     = string
#     port     = number
#     name     = string
#     user     = string
#     password = string
#   })
#   sensitive = true
# }

# variable "airbyte_enabled" {
#   description = "Whether to deploy the Airbyte module"
#   type        = bool
#   default     = false
# }

# variable "airflow_enabled" {
#   description = "Whether to deploy the Airflow module"
#   type        = bool
#   default     = false
# }

# variable "superset_enabled" {
#   description = "Whether to deploy the Superset module"
#   type        = bool
#   default     = false
# }

# variable "analytics_postgres_enabled" {
#   description = "Whether to deploy the Analytics Postgres module"
#   type        = bool
#   default     = false
# }

# variable "dagster_enabled" {
#   description = "Whether to deploy the Dagster module"
#   type        = bool
#   default     = false
# }

# variable "lightdash_enabled" {
#   description = "Whether to deploy the lightdash module"
#   type        = bool
#   default     = false
# }

# variable "tooljet_enabled" {
#   description = "Whether to deploy the tooljet module"
#   type        = bool
#   default     = false
# }

# variable "jitsu_enabled" {
#   description = "Whether to deploy the jitsu module"
#   type        = bool
#   default     = false
# }

# variable "superset_default_user" {
#   description = "Default user for Superset"
#   type        = string
#   default     = "admin@superset.com"
# }

# variable "superset_default_password" {
#   description = "Default user for Superset"
#   type        = string
#   default     = "admin"
# }

# variable "superset_secret_key" {
#   description = "Default user for Superset"
#   type        = string
#   default     = "YOUR_OWN_RANDOM_GENERATED_SECRET_KEY"
# }

# variable "argo_workflows_enabled" {
#   description = "Whether to deploy the argo workflows module"
#   type        = bool
#   default     = false
# }

# variable "argo_cd_enabled" {
#   description = "Whether to deploy the argo cd module"
#   type        = bool
#   default     = false
# }

# variable "windmill_enabled" {
#   description = "Whether to deploy the windmill module"
#   type        = bool
#   default     = false
# }

# variable "kestra_enabled" {
#   description = "Whether to deploy the kestra module"
#   type        = bool
#   default     = false
# }

# variable "kubernetes_dashboard_enabled" {
#   description = "Whether to deploy the kubernetes dashboard module"
#   type        = bool
#   default     = false
# }

# variable "kubernetes_config_path" {
#   description = "kubernetes config path"
#   type        = string
#   default     = "~/.kube/config"
# }

# variable "google_oauth_client_id" {
#   description = "Google OAuth client ID"
#   type        = string
#   default     = ""
# }

# variable "google_oauth_client_secret" {
#   description = "Google OAuth client secret"
#   type        = string
#   default     = ""
# }

# variable "deployment_domain" {
#   description = "Deployment domain"
#   type        = string
#   default     = ""
# }

# variable "zone_domain" {
#   description = "Zone domain"
#   type        = string
#   default     = ""
# }

# variable "argo_workflows_subdomain" {
#   description = "The subdomain for Argo Workflows"
#   type        = string
#   default     = "argo-workflows"
# }

# variable "argocd_subdomain" {
#   description = "Subdomain for ArgoCD"
#   type        = string
#   default     = "argocd"
# }

# variable "airbyte_subdomain" {
#   description = "The subdomain for Airbyte"
#   type        = string
#   default     = "airbyte"
# }

# variable "airbyte_postgres_host" {
#   description = "Hostname for the Airbyte PostgreSQL database"
#   type        = string
# }

# variable "airbyte_postgres_port" {
#   description = "Port for the Airbyte PostgreSQL database"
#   type        = number
#   default     = 5432
# }

# variable "airbyte_postgres_name" {
#   description = "Name of the Airbyte PostgreSQL database"
#   type        = string
# }

# variable "airbyte_postgres_user" {
#   description = "Username for the Airbyte PostgreSQL database"
#   type        = string
# }

# variable "airbyte_postgres_password" {
#   description = "Password for the Airbyte PostgreSQL database"
#   type        = string
#   sensitive   = true
# }