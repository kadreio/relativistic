provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "minio" {
  source = "../../"

  minio_servers = 1
  minio_volumes_per_server = 1
  minio_storage_size = "10Gi"
  minio_access_key = "minio"
  minio_secret_key = "minio123"
  minio_exposed_port = 30900
}
