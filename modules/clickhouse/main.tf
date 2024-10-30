resource "random_string" "clickhouse_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "helm_release" "clickhouse" {
    name = "clickhouse-${random_string.clickhouse_suffix.result}"
    repository = "https://docs.altinity.com/clickhouse-operator"
    version = var.clickhouse_chart_version
    chart = "altinity-clickhouse-operator"
    values = [var.override_helm_values]
}

variable "clickhouse_chart_version" {
    description = "Clickhouse chart version"
    type = string
    default = "0.24.0"
}

variable "override_helm_values" {
    description = "Override helm values"
    type = string
    default = ""
}

resource "kubectl_manifest" "clickhouse_instance" {
  yaml_body = templatefile("${path.module}/clickhouse.yaml.tpl", {
    name = "clickhouse-1"
  })
} 

terraform {
  required_providers {
    kubectl = {
      source = "alekc/kubectl"
      version = ">= 2.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}