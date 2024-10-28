resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  version    = var.elasticsearch_chart_version
  force_update = true
  timeout    = 1200

  values = concat([
    templatefile("${path.module}/helm_values.yaml", {
      elasticsearch_replicas = var.elasticsearch_replicas,
      elasticsearch_heap_size = var.elasticsearch_heap_size,
      elasticsearch_storage_size = var.elasticsearch_storage_size,
      elasticsearch_local_exposed_port = var.elasticsearch_local_exposed_port
    })
  ], var.override_helm_values)
}
