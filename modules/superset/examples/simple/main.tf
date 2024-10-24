provider "kubernetes" {
    config_path = "~/.kube/config"
}

provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
    }
}

module "superset" {
    source = "kadreio/relativistic/kubernetes//modules/superset"
    superset_secret_key = random_string.cookie_key.result
}

resource "random_string" "cookie_key" {
    length  = 32
    special = false
}