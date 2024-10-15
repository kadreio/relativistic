variable "kubernetes_config_path" {
  description = "Path to the kubeconfig file"
  type        = string
}

provider "kubernetes" {
  config_path = var.kubernetes_config_path
}

provider "helm" {
  kubernetes {
    config_path = var.kubernetes_config_path
  }
}

module "relativistic" {
  source = "../"  // This assumes the module is in the parent directory

  superset_enabled         = true
  superset_default_password = "test_password"
  superset_default_user    = "test@example.com"
  superset_secret_key      = "test_secret_key"
}
