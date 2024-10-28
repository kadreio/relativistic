variable "namespace" {
  description = "Kubernetes namespace for MinIO deployment"
  type        = string
  default     = "minio-tenant"
}

variable "minio_operator_chart_version" {
  description = "MinIO Operator chart version"
  type        = string
  default     = "6.0.3"
}

variable "minio_tenant_chart_version" {
  description = "MinIO Tenant chart version"
  type        = string
  default     = "6.0.3"
}

variable "minio_servers" {
  description = "Number of MinIO servers"
  type        = number
  default     = 4
}

variable "minio_volumes_per_server" {
  description = "Number of volumes per MinIO server"
  type        = number
  default     = 4
}

variable "minio_storage_size" {
  description = "Storage size for each MinIO volume"
  type        = string
  default     = "10Gi"
}

variable "minio_access_key" {
  description = "MinIO access key"
  type        = string
}

variable "minio_secret_key" {
  description = "MinIO secret key"
  type        = string
}

variable "minio_exposed_port" {
  description = "Port to expose MinIO service"
  type        = number
  default     = 30900
}

variable "override_helm_values" {
  description = "List of Helm values files to override default configurations"
  type        = list(string)
  default     = []
}
