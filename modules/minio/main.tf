resource "helm_release" "minio_operator" {
  name             = "minio-operator"
  repository       = "https://operator.min.io/"
  chart            = "operator"
  version          = var.minio_operator_chart_version
  namespace        = var.namespace
  create_namespace = true

  set {
    name  = "tenants.enabled"
    value = "false"
  }
}

resource "helm_release" "minio_tenant" {
  name       = "minio-tenant"
  repository = "https://operator.min.io/"
  chart      = "tenant"
  version    = var.minio_tenant_chart_version
  namespace  = var.namespace
  depends_on = [helm_release.minio_operator]

  values = concat([
    templatefile("${path.module}/helm_values.yaml", {
      minio_servers            = var.minio_servers,
      minio_volumes_per_server = var.minio_volumes_per_server,
      minio_storage_size       = var.minio_storage_size,
      minio_access_key         = var.minio_access_key,
      minio_secret_key         = var.minio_secret_key,
      minio_exposed_port       = var.minio_exposed_port
    })
  ], var.override_helm_values)
}
