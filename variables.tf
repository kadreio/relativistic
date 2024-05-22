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