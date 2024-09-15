provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "relativistic" {
    source = "../../"

    superset = {
        enabled = true
        default_password = "starting_password_to_change"
        default_user = "you@yourcompany.com"
        secret_key = random_string.cookie_key.result
    }
}

resource "random_string" "cookie_key" {
    length  = 32
    special = false
}