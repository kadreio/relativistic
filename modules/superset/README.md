# Superset 

{bdg-warning}`Beta`

### Overview

This module deploys Apache Superset, a modern data exploration and visualization platform, on Kubernetes. It sets up the Superset web application, its dependencies, and the necessary database using a Helm chart. The module also configures authentication and exposes the Superset UI for easy access to data analytics and dashboard creation.

### Compute Nodes

For optimal performance, the following resources are recommended:
- 1 or more CPU cores
- At least 2GB of memory

### Local Deployment

Superset will start on port 30086 by default.

### Production Considerations

Superset is licensed under the Apache License 2.0.


```{Warning}
  Superset will deploy a self-hosted version of Postgres. This will not back iteslf up, and is not HA. For many use cases, this is not a problem, as Superset is not a system of record itself, and can easily be recreated in disaster recovery. External postgres can be configured by helm chart overrides., but future work will simplify passing in an existing postgres instance.  
```
### Examples

```hcl
module "superset" {
    source = "kadreio/relativistic/kubernetes//modules/superset"
    #The key used for superset cookies
    superset_secret_key = random_string.cookie_key.result

    #The default user for superset, set this to the first admin's email
    superset_default_user = "admin@example.com"

    #The default password for that admin user, change this after initial login
    superset_default_password = "password"

    #The port that the superset service will be exposed on for local access
    superset_local_exposed_port = 30086
}

resource "random_string" "cookie_key" {
    length  = 32
    special = false
}
```

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_override_helm_values"></a> [override\_helm\_values](#input\_override\_helm\_values) | List of Helm values files to override default configurations | `list(string)` | `[]` | no |
| <a name="input_superset_chart_version"></a> [superset\_chart\_version](#input\_superset\_chart\_version) | Superset chart version | `string` | `"0.12.9"` | no |
| <a name="input_superset_default_password"></a> [superset\_default\_password](#input\_superset\_default\_password) | Default User Password for Superset | `string` | `"admin"` | no |
| <a name="input_superset_default_user"></a> [superset\_default\_user](#input\_superset\_default\_user) | Default user for Superset | `string` | `"admin@superset.com"` | no |
| <a name="input_superset_local_exposed_port"></a> [superset\_local\_exposed\_port](#input\_superset\_local\_exposed\_port) | Local exposed port for Superset | `number` | `30086` | no |
| <a name="input_superset_secret_key"></a> [superset\_secret\_key](#input\_superset\_secret\_key) | Default Secret Jey for Superset | `string` | n/a | yes |

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
