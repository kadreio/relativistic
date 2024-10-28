variable "elasticsearch_chart_version" {
  description = "Elasticsearch chart version"
  type        = string
  default     = "7.17.3"
}

variable "elasticsearch_replicas" {
  description = "Number of Elasticsearch replicas"
  type        = number
  default     = 1
}

variable "elasticsearch_heap_size" {
  description = "Elasticsearch heap size"
  type        = string
  default     = "512m"
}

variable "elasticsearch_storage_size" {
  description = "Elasticsearch storage size"
  type        = string
  default     = "30Gi"
}

variable "elasticsearch_local_exposed_port" {
  description = "Local exposed port for Elasticsearch"
  type        = number
  default     = 30092
}

variable "override_helm_values" {
  description = "List of Helm values files to override default configurations"
  type        = list(string)
  default     = []
}
