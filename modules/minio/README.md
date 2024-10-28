# MinIO

## Overview

This module deploys MinIO, a high-performance object storage system, on Kubernetes using Helm. It sets up the MinIO server with configurable replicas, storage size, and access credentials.

## Example Usage

From [examples/simple/main.tf](https://github.com/your-repo/path/to/module/minio/examples/simple/main.tf)

```hcl
provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "minio" {
  source = "path/to/minio/module"

  minio_replicas = 1
  minio_storage_size = "10Gi"
  minio_access_key = "minio"
  minio_secret_key = "minio123"
  minio_local_exposed_port = 30900
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| minio_chart_version | MinIO chart version | `string` | `"5.0.7"` | no |
| minio_replicas | Number of MinIO replicas | `number` | `1` | no |
| minio_storage_size | MinIO storage size | `string` | `"10Gi"` | no |
| minio_access_key | MinIO access key | `string` | `"minio"` | no |
| minio_secret_key | MinIO secret key | `string` | `"minio123"` | no |
| minio_local_exposed_port | Local exposed port for MinIO | `number` | `30900` | no |
| override_helm_values | List of Helm values files to override default configurations | `list(string)` | `[]` | no |

## Outputs

No outputs.

## Providers

| Name | Version |
|------|---------|
| helm | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.minio](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Modules

No modules.
