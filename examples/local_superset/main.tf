provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "relativistic" {
    source = "kadreio/relativistic/kubernetes"

    superset_enabled = true
    superset_default_password = "starting_password_to_change"
    superset_default_user = "you@yourcompany.com"
    superset_secret_key = random_string.cookie_key.result
}

resource "random_string" "cookie_key" {
    length  = 32
    special = false
}