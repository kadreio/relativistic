provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "relativistic" {
    source = "git@github.com:kadreio/relativistic.git?ref=v0.1.2"
    argo_workflows_enabled = true
}


resource "kubernetes_manifest" "service" {
  depends_on = [
    module.relativistic
  ]
  manifest = yamldecode(file("./dbt_workflow.yaml"))
}
