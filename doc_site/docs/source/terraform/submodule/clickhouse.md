# Clickhouse 

{bdg-danger}`In Development`


### Overview

This module deploys a ClickHouse database on Kubernetes. It uses the official ClickHouse Helm chart to set up a reliable columnar database instance, suitable for high-performance analytics and data warehousing in the cluster. The module also provides outputs for easy access to database connection details.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clickhouse_chart_version"></a> [clickhouse\_chart\_version](#input\_clickhouse\_chart\_version) | Clickhouse chart version | `string` | `"0.24.0"` | no |
| <a name="input_override_helm_values"></a> [override\_helm\_values](#input\_override\_helm\_values) | Override helm values | `string` | `""` | no |

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
| [helm_release.clickhouse](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

### Modules

No modules.
