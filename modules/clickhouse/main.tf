resource "helm_release" "clickhouse" {
    name = "clickhouse"
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