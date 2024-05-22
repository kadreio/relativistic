resource "helm_release" "tooljet" {
  name       = "tooljet"
  repository = "https://tooljet.github.io/helm-charts"
  chart      = "tooljet"
  version    = "2.25.0"

  values = [file("${path.module}/helm_values.yaml")]
}
