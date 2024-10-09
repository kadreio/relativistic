variable "lightdash_chart_version" {
  description = "Lightdash chart version"
  type        = string
  default     = "0.8.9"
}

resource "helm_release" "lightdash" {
  name       = "lightdash"
  repository = "https://lightdash.github.io/helm-charts"
  chart      = "lightdash"
  version    = var.lightdash_chart_version

  values = [file("${path.module}/helm_values.yaml")]
}