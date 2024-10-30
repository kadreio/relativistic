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

# module "relativistic" {
#     source = "../../"
#     clickhouse_enabled = true
#     clickhouse_password_sha256_hex = "153913a8df6d33f356847fb367ab0da2b1f828fc7a96cf38898560112983ae4a"
# }

module "relativistic2" {
    source = "../../"
    clickhouse_enabled = true
    superset_enabled = true
    airbyte_enabled = true
    airbyte_enable_proxy = false    
}

# module "clickhouse" {
#     source = "../../modules/clickhouse"
#     clickhouse_password_sha256_hex = "153913a8df6d33f356847fb367ab0da2b1f828fc7a96cf38898560112983ae4a"
# }


terraform {
  required_providers {
    kubectl = {
      source = "alekc/kubectl"
      version = ">= 2.0.0"
    }
  }
}