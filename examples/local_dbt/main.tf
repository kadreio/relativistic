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
    argo_workflows_enabled = true
}


resource "kubernetes_manifest" "service" {
  depends_on = [
    module.relativistic
  ]
  manifest = yamldecode(file("./dbt_workflow.yaml"))
}
