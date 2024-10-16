# Superset Module



### Overview

This module deploys Apache Superset, a modern data exploration and visualization platform, on Kubernetes. It sets up the Superset web application, its dependencies, and the necessary database using a Helm chart. The module also configures authentication and exposes the Superset UI for easy access to data analytics and dashboard creation.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_superset_chart_version"></a> [superset\_chart\_version](#input\_superset\_chart\_version) | Superset chart version | `string` | `"0.12.9"` | no |
| <a name="input_superset_default_password"></a> [superset\_default\_password](#input\_superset\_default\_password) | Default user for Superset | `string` | `"admin"` | no |
| <a name="input_superset_default_user"></a> [superset\_default\_user](#input\_superset\_default\_user) | Default user for Superset | `string` | `"admin@superset.com"` | no |
| <a name="input_superset_local_exposed_port"></a> [superset\_local\_exposed\_port](#input\_superset\_local\_exposed\_port) | Local exposed port for Superset | `number` | `30086` | no |
| <a name="input_superset_secret_key"></a> [superset\_secret\_key](#input\_superset\_secret\_key) | Default user for Superset | `string` | n/a | yes |

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
| [helm_release.superset](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

### Modules

No modules.
