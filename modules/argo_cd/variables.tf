variable "argo_cd_chart_version" {
  description = "Argo CD chart version"
  type        = string
  default     = "7.4.3"
}

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
  default     = "localhost:30088"
} 