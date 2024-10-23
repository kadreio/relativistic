# Readme Module



### Overview

This module deploys a PostgreSQL database specifically for analytics purposes on Kubernetes. It uses the Bitnami PostgreSQL Helm chart to set up a robust and scalable database instance, suitable for storing and querying large datasets in analytics workflows.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_analytics_postgres_chart_version"></a> [analytics\_postgres\_chart\_version](#input\_analytics\_postgres\_chart\_version) | Analytics Postgres chart version | `string` | `"15.2.5"` | no |

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
| [helm_release.analytics_postgres](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

### Modules

No modules.
