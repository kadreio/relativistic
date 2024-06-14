variable "airbyte_enabled" {
  description = "Whether to deploy the Airbyte module"
  type        = bool
  default     = false
}

variable "airflow_enabled" {
  description = "Whether to deploy the Airflow module"
  type        = bool
  default     = false
}

variable "superset_enabled" {
  description = "Whether to deploy the Superset module"
  type        = bool
  default     = false
}

variable "analytics_postgres_enabled" {
  description = "Whether to deploy the Analytics Postgres module"
  type        = bool
  default     = false
}

variable "dagster_enabled" {
  description = "Whether to deploy the Dagster module"
  type        = bool
  default     = false
}
variable "lightdash_enabled" {
  description = "Whether to deploy the lightdash module"
  type        = bool
  default     = false
}

variable "tooljet_enabled" {
  description = "Whether to deploy the tooljet module"
  type        = bool
  default     = false
}

variable "jitsu_enabled" {
  description = "Whether to deploy the jitsu module"
  type        = bool
  default     = false
}
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
  default     = "YOUR_OWN_RANDOM_GENERATED_SECRET_KEY"
}

variable "argo_workflows_enabled" {
  description = "Whether to deploy the argo workflows module"
  type        = bool
  default     = false
}

variable "windmill_enabled" {
  description = "Whether to deploy the windmill module"
  type        = bool
  default     = false
}

variable "kubernetes_config_path" {
  description = "kubernetes config path"
  type        = string
  default     = "~/.kube/config"
}





