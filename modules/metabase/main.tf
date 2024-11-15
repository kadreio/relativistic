variable "metabase_chart_version" {
  description = "Metabase chart version"
  type        = string
  default     = "2.16.7"
}

# variable "override_helm_values" {
#   description = "List of Helm values files to override default configurations for Lightdash"
#   type        = list(string)
#   default     = []
# }


resource "helm_release" "metabase" {
  name       = "pmint93-metabase"
  repository = "https://pmint93.github.io/helm-charts"
  chart      = "metabase"
  version    = var.metabase_chart_version

  # values = concat([
  #   file("${path.module}/helm_values.yaml")
  # ], var.override_helm_values)
  
  force_update = true
}
