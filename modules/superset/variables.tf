variable "superset_default_user" {
  description = "Default user for Superset"
  type        = string
  default     = "admin@superset.com"
}

variable "superset_default_password" {
  description = "Default user for Superset"
  type        = string
  default     = "admin"
}

variable "superset_secret_key" {
  description = "Default user for Superset"
  type        = string
}

variable "superset_local_exposed_port" {
  description = "Local exposed port for Superset"
  type        = number
  default     = 30086
}

variable "override_helm_values" {
  description = "List of Helm values files to override default configurations"
  type        = list(string)
  default     = []
}
