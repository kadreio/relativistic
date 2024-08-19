resource "helm_release" "cloudnativepg" {
  name       = "cloudnativepg"
  repository = "https://cloudnative-pg.github.io/charts"
  chart      = "cloudnative-pg"
  version    = "0.21.6"
}


# helm repo add cnpg https://cloudnative-pg.github.io/charts
# helm upgrade --install cnpg \
# --namespace cnpg-system \
# --create-namespace \
# cnpg/cloudnative-pg