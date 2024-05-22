resource "helm_release" "superset" {
  name       = "superset"
  repository = "https://apache.github.io/superset"
  chart      = "superset"
  version    = "0.12.9"

  values = [file("${path.module}/helm_values.yaml")]
}