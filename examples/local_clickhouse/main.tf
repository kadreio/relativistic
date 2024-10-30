provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubectl" {
  config_path = "~/.kube/config"
}

module "relativistic" {
    source = "../../"
    clickhouse_enabled = true
}

module "relativistic2" {
    source = "../../"
    clickhouse_enabled = true
}


terraform {
  required_providers {
    kubectl = {
      source = "alekc/kubectl"
      version = ">= 2.0.0"
    }
  }
}