terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# Define variables
variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
}

resource "digitalocean_certificate" "superset_cert" {
  name    = "superset-cert"
  type    = "lets_encrypt"
  domains = ["sp.vexed.io"]  # Replace with your desired domain
}

# Create a new DOKS cluster
resource "digitalocean_kubernetes_cluster" "example_cluster" {
  name    = "example-doks-cluster"
  region  = "nyc1"
  version = "1.31.1-do.0"  # Check for the latest version

  node_pool  {
    name       = "worker-pool"
    size       = "s-2vcpu-8gb-amd"
    min_nodes  = 5
    max_nodes  = 10
    auto_scale = true
  }
  
}



provider "helm" {
  kubernetes {
    host                   = digitalocean_kubernetes_cluster.example_cluster.endpoint
    token                  = digitalocean_kubernetes_cluster.example_cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.example_cluster.kube_config[0].cluster_ca_certificate)
  }
}

provider "kubernetes" {
    host                   = digitalocean_kubernetes_cluster.example_cluster.endpoint
    token                  = digitalocean_kubernetes_cluster.example_cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.example_cluster.kube_config[0].cluster_ca_certificate)
}

resource "helm_release" "kube_state_metrics" {
  name       = "kube-state-metrics"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-state-metrics"
  namespace  = "kube-system"
  version    = "5.15.2"  # You can specify a version or omit for the latest

  set {
    name  = "autosharding.enabled"
    value = "true"
  }

  set {
    name  = "metricLabelsAllowlist[0]"
    value = "pods=[*]"
  }

  set {
    name  = "metricAnnotationsAllowList[0]"
    value = "pods=[*]"
  }
}

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.11.0"  # You can specify a version or omit for the latest

  set {
    name  = "args[0]"
    value = "--kubelet-insecure-tls"
  }

  set {
    name  = "args[1]"
    value = "--kubelet-preferred-address-types=InternalIP"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }
}

resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
  version    = "9.29.0"  # Check for the latest version

  set {
    name  = "autoDiscovery.clusterName"
    value = digitalocean_kubernetes_cluster.example_cluster.name
  }

  set {
    name  = "extraArgs.scale-down-utilization-threshold"
    value = "0.5"
  }

  set {
    name  = "extraArgs.scale-down-delay-after-add"
    value = "5m"
  }

  set {
    name  = "extraArgs.scale-up-from-zero"
    value = "true"
  }
}

module "relativistic" {
    source = "../../"
    superset_enabled = true
    superset_default_password = "starting_password_to_change"
    superset_default_user = "you@yourcompany.com"
    superset_secret_key = random_string.cookie_key.result

    airbyte_enabled = true
    airbyte_userlist = <<EOF
        fake@example.com
        fake2@example.com
      EOF 

    airflow_enabled = true

    analytics_postgres_enabled = true

    lightdash_enabled = true

    argo_workflows_enabled = true
    argo_workflows_subdomain = "argo-workflows"
    argo_workflows_rbac_rule = "false"

    argo_cd_enabled = true
    argo_cd_subdomain = "argocd"

    windmill_enabled = true
    prometheus_enabled = true

    google_oauth_client_id = "1234567890"
    google_oauth_client_secret = "1234567890"
}

resource "kubernetes_service" "superset_loadbalancer" {
#   depends_on = [time_sleep.wait_for_certificate]
  metadata {
    name = "superset-loadbalancer"
    annotations = {
      "service.beta.kubernetes.io/do-loadbalancer-protocol"      = "https"
      "service.beta.kubernetes.io/do-loadbalancer-tls-ports"     = "443"
      "service.beta.kubernetes.io/do-loadbalancer-redirect-http-to-https" = "true"
      "service.beta.kubernetes.io/do-loadbalancer-certificate-id" = digitalocean_certificate.superset_cert.uuid
    }
  }
  spec {
    selector = {
      app = "superset"
    }
    type = "LoadBalancer"
    port {
      port        = 443
      target_port = 8080
    }
  }
}

# Create a DigitalOcean DNS A record for sp.vexed.io
resource "digitalocean_record" "superset_a_record" {
  domain = "vexed.io"
  type   = "A"
  name   = "sp"
  value  = kubernetes_service.superset_loadbalancer.status.0.load_balancer.0.ingress.0.ip
  ttl    = 3600  # 1 hour TTL, adjust as needed
}



output "superset_loadbalancer_endpoint" {
  value       = "https://${kubernetes_service.superset_loadbalancer.status.0.load_balancer.0.ingress.0.ip}"
  description = "The HTTPS endpoint of the Superset LoadBalancer"
}

output "superset_loadbalancer_ip" {
  value = kubernetes_service.superset_loadbalancer.status.0.load_balancer.0.ingress.0.ip
  description = "The external IP address of the Superset LoadBalancer"
}

resource "random_string" "cookie_key" {
    length  = 32
    special = false
}


# Output the cluster endpoint and kubeconfig
output "cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.example_cluster.endpoint
}