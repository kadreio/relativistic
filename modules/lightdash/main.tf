variable "lightdash_chart_version" {
  description = "Lightdash chart version"
  type        = string
  default     = "0.8.9"
}

variable "override_helm_values" {
  description = "List of Helm values files to override default configurations for Lightdash"
  type        = list(string)
  default     = []
}

resource "helm_release" "lightdash" {
  name       = "lightdash"
  repository = "https://lightdash.github.io/helm-charts"
  chart      = "lightdash"
  version    = var.lightdash_chart_version

  values = concat([
    file("${path.module}/helm_values.yaml")
  ], var.override_helm_values)
  
  force_update = true
}
