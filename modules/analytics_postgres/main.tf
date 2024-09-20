resource "helm_release" "analytics_postgres" {
  name       = "analytics-postgres"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "15.2.5"
  values     = [file("./${path.module}/helm_values.yaml")]
  timeout = 1200
}