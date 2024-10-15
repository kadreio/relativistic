# Airflow Module



### Overview

This module deploys Apache Airflow, a platform to programmatically author, schedule, and monitor workflows, on Kubernetes. It sets up the Airflow webserver, scheduler, and workers using a Helm chart. The module also configures persistent storage and exposes the Airflow UI.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_airflow_chart_version"></a> [airflow\_chart\_version](#input\_airflow\_chart\_version) | Airflow chart version | `string` | `"8.8.0"` | no |

### Outputs

No outputs.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

### Requirements

No requirements.

### Resources

| Name | Type |
|------|------|
| [helm_release.airflow](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_service.expose_airflow_webserver](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |

### Modules

No modules.
