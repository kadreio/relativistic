variable "analytics_postgres_chart_version" {
  description = "Analytics Postgres chart version"
  type        = string
  default     = "15.2.5"
}

resource "helm_release" "analytics_postgres" {
  name       = "analytics-postgres"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = var.analytics_postgres_chart_version
  force_update = true
  values     = [
    file("${path.module}/helm_values.yaml"),
    var.override_helm_values
  ]
}

variable "override_helm_values" {
  description = "Override helm values"
  type        = string
  default     = ""
}
