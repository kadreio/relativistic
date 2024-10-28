provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "elasticsearch" {
  source = "../../"

  elasticsearch_replicas = 1
  elasticsearch_heap_size = "1g"
  elasticsearch_storage_size = "30Gi"
  elasticsearch_local_exposed_port = 30092
}
