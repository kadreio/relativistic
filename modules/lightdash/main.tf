resource "helm_release" "lightdash" {
  name       = "lightdash"
  repository = "https://lightdash.github.io/helm-charts"
  chart      = "lightdash"
  version    = "0.8.9"

  values = [file("${path.module}/helm_values.yaml")]
}