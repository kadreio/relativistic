# Clickhouse 

{bdg-danger}`In Development`


### Overview

This module deploys a ClickHouse database on Kubernetes. It uses the official ClickHouse Helm chart to set up a reliable columnar database instance, suitable for high-performance analytics and data warehousing in the cluster. The module also provides outputs for easy access to database connection details.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clickhouse_chart_version"></a> [clickhouse\_chart\_version](#input\_clickhouse\_chart\_version) | Clickhouse chart version | `string` | `"0.24.0"` | no |
| <a name="input_clickhouse_password_sha256_hex"></a> [clickhouse\_password\_sha256\_hex](#input\_clickhouse\_password\_sha256\_hex) | Clickhouse password sha256 hex | `string` | `"10a6e6cc8311a3e2bcc09bf6c199adecd5dd59408c343e926b129c4914f3cb01"` | no |
| <a name="input_override_helm_values"></a> [override\_helm\_values](#input\_override\_helm\_values) | Override helm values | `string` | `""` | no |

### Outputs

No outputs.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 2.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.0 |

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 2.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

### Resources

| Name | Type |
|------|------|
| [helm_release.clickhouse](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.clickhouse_instance](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.clickhouse_storage_class](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [random_string.clickhouse_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

### Modules

No modules.
