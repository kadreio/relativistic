resource "random_string" "clickhouse_suffix" {
  length  = 4
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

variable "clickhouse_password_sha256_hex" {
    description = "Clickhouse password sha256 hex"
    type = string
    default = "10a6e6cc8311a3e2bcc09bf6c199adecd5dd59408c343e926b129c4914f3cb01"
}

resource "kubectl_manifest" "clickhouse_storage_class" {
  yaml_body = templatefile("${path.module}/clickhouse_storage.yaml.tpl", {
    name = "${random_string.clickhouse_suffix.result}"
  })
} 

resource "kubectl_manifest" "clickhouse_instance" {
 depends_on = [kubectl_manifest.clickhouse_storage_class]
  yaml_body = templatefile("${path.module}/clickhouse.yaml.tpl", {
    name = "${random_string.clickhouse_suffix.result}",
    clickhouse_password_sha256_hex = var.clickhouse_password_sha256_hex
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