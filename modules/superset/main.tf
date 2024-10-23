variable "superset_chart_version" {
  description = "Superset chart version"
  type        = string
  default     = "0.12.9"
}

resource "helm_release" "superset" {
  name       = "superset"
  repository = "https://apache.github.io/superset"
  chart      = "superset"
  version    = var.superset_chart_version
  force_update = true
  timeout = 1200

  values = concat([
    templatefile("${path.module}/helm_values.yaml", {
      superset_default_user = var.superset_default_user,
      superset_default_password = var.superset_default_password,
      superset_secret_key = var.superset_secret_key,
      superset_local_exposed_port = var.superset_local_exposed_port
    })
  ], var.override_helm_values)
}
