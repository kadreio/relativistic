# Dagster Module



### Overview

This module deploys Dagster, an open-source data orchestration platform, on Kubernetes. It sets up the Dagster webserver, daemon, and user code deployments using a Helm chart. The module also configures persistent storage and enables the necessary services for running data pipelines and workflows.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dagster_chart_version"></a> [dagster\_chart\_version](#input\_dagster\_chart\_version) | Dagster chart version | `string` | `"1.7.1"` | no |

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
| [helm_release.dagster](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

### Modules

No modules.
