# Prometheus Module



### Overview

This module deploys Prometheus, an open-source systems monitoring and alerting toolkit, on Kubernetes. It sets up the Prometheus server, Alertmanager, and various exporters using the kube-prometheus-stack Helm chart. The module also deploys Loki for log aggregation, providing a comprehensive monitoring and logging solution for the cluster.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_loki_chart_version"></a> [loki\_chart\_version](#input\_loki\_chart\_version) | Loki chart version | `string` | `"2.10.0"` | no |
| <a name="input_prometheus_operator_chart_version"></a> [prometheus\_operator\_chart\_version](#input\_prometheus\_operator\_chart\_version) | Prometheus Operator chart version | `string` | `"61.9.0"` | no |

### Outputs

No outputs.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

### Requirements

No requirements.

### Resources

| Name | Type |
|------|------|
| [helm_release.loki](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.prometheus_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

### Modules

No modules.
