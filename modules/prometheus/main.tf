resource "helm_release" "prometheus_operator" {
  name       = "prometheus-operator"
  namespace  = "monitoring"
  create_namespace = true
  timeout = 1200

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "61.9.0" # Check for the latest version

  values     = [file("./${path.module}/helm_values.yaml")]

}

resource "helm_release" "loki" {
  name             = "loki"
  namespace        = "monitoring"
  create_namespace = true
  timeout          = 1200
  values     = [file("./${path.module}/loki_values.yaml")]

  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = "6.10.0" # Check for the latest version

  # values = [file("./${path.module}/loki_values.yaml")]

  depends_on = [helm_release.prometheus_operator]
}
