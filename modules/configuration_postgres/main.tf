resource "helm_release" "configuration_postgres" {
  name       = "configuration-postgres"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "15.2.5"
  values     = [file("./${path.module}/helm_values.yaml")]
}

data "kubernetes_service" "configuration_postgres" {
  metadata {
    name = "configuration-postgres-postgresql"
  }
  depends_on = [helm_release.configuration_postgres]
}

data "kubernetes_secret" "configuration_postgres" {
  metadata {
    name = "configuration-postgres-postgresql"
  }
  depends_on = [helm_release.configuration_postgres]
}

output  "postgres_host" {
  value = data.kubernetes_service.configuration_postgres.spec[0].cluster_ip
}

output  "postgres_service_port" {
  value = data.kubernetes_service.configuration_postgres.spec[0].port[0].port
}

output  "postgres_service_database" {
  value = "postgres"
}

output  "postgres_username" {
  value = "postgres"
}

output "postgres_password" {
  value = data.kubernetes_secret.configuration_postgres.data["postgres-password"]
  sensitive = true
}