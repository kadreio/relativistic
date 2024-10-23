variable "prometheus_operator_chart_version" {
  description = "Prometheus Operator chart version"
  type        = string
  default     = "61.9.0"
}

variable "loki_chart_version" {
  description = "Loki chart version"
  type        = string
  default     = "2.10.0"
}

variable "prometheus_override_helm_values" {
  description = "List of Helm values files to override default configurations for Prometheus"
  type        = list(string)
  default     = []
}

variable "loki_override_helm_values" {
  description = "List of Helm values files to override default configurations for Loki"
  type        = list(string)
  default     = []
}

resource "helm_release" "prometheus_operator" {
  name       = "prometheus-operator"
  namespace  = "monitoring"
  create_namespace = true
  timeout = 1200

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.prometheus_operator_chart_version

  values = concat([
    file("${path.module}/helm_values.yaml")
  ], var.prometheus_override_helm_values)

  force_update = true
}

resource "helm_release" "loki" {
  name             = "loki"
  namespace        = "monitoring"
  create_namespace = true
  timeout          = 1200

  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = var.loki_chart_version

  values = concat([
    file("${path.module}/loki_values.yaml")
  ], var.loki_override_helm_values)

  depends_on = [helm_release.prometheus_operator]
}
