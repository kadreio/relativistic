resource "helm_release" "dagster" {
  name       = "dagster"
  repository = "https://dagster-io.github.io/helm"
  chart      = "dagster"
  version    = "1.7.1"

  values = [file("${path.module}/dagster_values.yaml")]
  timeout = 1200
}
