// Add this new variable
variable "override_helm_values" {
  description = "Override helm values as YAML string"
  type        = string
  default     = ""
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
