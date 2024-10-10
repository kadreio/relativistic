variable "prometheus_operator_chart_version" {
  description = "Prometheus Operator chart version"
  type        = string
  default     = "61.9.0"
}

resource "helm_release" "prometheus_operator" {
  name       = "prometheus-operator"
  namespace  = "monitoring"
  create_namespace = true
  timeout = 1200

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.prometheus_operator_chart_version # Check for the latest version

  values     = [file("./${path.module}/helm_values.yaml")]

  force_update = true
}

variable "loki_chart_version" {
  description = "Loki chart version"
  type        = string
  default     = "2.10.0"
}

resource "helm_release" "loki" {
  name             = "loki"
  namespace        = "monitoring"
  create_namespace = true
  timeout          = 1200
  values     = [file("./${path.module}/loki_values.yaml")]

  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = var.loki_chart_version # Check for the latest version

  # values = [file("./${path.module}/loki_values.yaml")]

  depends_on = [helm_release.prometheus_operator]
}
