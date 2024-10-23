variable "dagster_chart_version" {
  description = "Dagster chart version"
  type        = string
  default     = "1.7.1"
}

variable "override_helm_values" {
  description = "Override helm values as YAML string"
  type        = string
  default     = ""
}

resource "helm_release" "dagster" {
  name       = "dagster"
  repository = "https://dagster-io.github.io/helm"
  chart      = "dagster"
  version    = var.dagster_chart_version
  values     = [
    file("${path.module}/dagster_values.yaml"),
    var.override_helm_values
  ]
  timeout = 1200
  force_update = true
}
